import 'package:flutter/material.dart';

import 'package:gutentag/domain/copyright.dart';
import 'package:gutentag/domain/language.dart';
import 'package:gutentag/domain/sort.dart';
import 'package:gutentag/domain/use_case/search_use_case.dart';

import 'package:gutentag/ui/common/book_card_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchViewModel {
  final SearchUseCase searchBooksUseCase;
  SearchViewModel({required this.searchBooksUseCase});

  String _query = "";
  String get query => _query;
  set query(String value) {
    _query = value;
    _resetPagination();
  }

  String _topic = "";
  String get topic => _topic;
  set topic(String value) {
    _topic = value;
    _resetPagination();
  }

  final sortOption = ValueNotifier(Sort.popular);
  final copyrightOptions = ValueNotifier(Copyright.values);
  final languages = ValueNotifier(<Language>[]);
  static const writtenStartMin = -3500;
  static const writtenEndMax = 2023;
  final writtenBetween = ValueNotifier(const MapEntry(writtenStartMin, writtenEndMax));

  final results = ValueNotifier<List<BookCardState>?>(null);
  final isLoading = ValueNotifier(false);

  int? _nextPage = 1;

  void setSortOption(Sort option) {
    sortOption.value = option;
    _resetPagination();
  }

  void toggleCopyrightOption(Copyright option) {
    if (copyrightOptions.value.any((element) => element == option)) {
      copyrightOptions.value = [...copyrightOptions.value]..remove(option);
    } else {
      copyrightOptions.value = [...copyrightOptions.value, option];
    }
    _resetPagination();
  }

  void setAuthorAliveBetween(int start, int end) {
    writtenBetween.value = MapEntry(start, end);
    _resetPagination();
  }

  void toggleLanguage(Language language) {
    if (languages.value.any((element) => element == language)) {
      languages.value = [...languages.value]..remove(language);
    } else {
      languages.value = [...languages.value, language];
    }
    _resetPagination();
  }

  void setLanguages(List<Language> languages) {
    this.languages.value = languages;
    _resetPagination();
  }

  void loadNextPage() async {
    final page = _nextPage;
    if (page == null || isLoading.value) return;

    isLoading.value = true;

    final newBooks = await searchBooksUseCase.search(
        query: _query,
        sortOption: sortOption.value,
        copyrightOptions: copyrightOptions.value,
        writtenStart: writtenBetween.value.key,
        writtenEnd: writtenBetween.value.value,
        topic: _topic,
        languages: languages.value,
        page: page);
    if (newBooks != null) {
      final pageOfBookCards = newBooks.results
          .map((b) => BookCardState.fromEntity(entity: b))
          .toList();
      results.value = [
        ...?page == 1 ? null : results.value,
        ...pageOfBookCards
      ];
      _nextPage = newBooks.next ? page + 1 : null;
    }

    isLoading.value = false;
  }

  void _resetPagination() {
    _nextPage = 1;
  }

  void dispose() {
    sortOption.dispose();
    copyrightOptions.dispose();
    languages.dispose();
    writtenBetween.dispose();
    results.dispose();
    isLoading.dispose();
  }
}
