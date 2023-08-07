import 'package:flutter/material.dart';
import 'package:gutentag/domain/copyright.dart';
import 'package:gutentag/domain/use_case/search_use_case.dart';
import 'package:gutentag/domain/sort.dart';
import 'package:gutentag/ui/common/book_card_state.dart';

class SearchViewModel {
  final SearchUseCase searchBooksUseCase;

  SearchViewModel({required this.searchBooksUseCase});

  final sortOption = ValueNotifier(Sort.popular);
  final query = ValueNotifier("");
  final copyrightOptions = ValueNotifier(Copyright.values);
  final results = ValueNotifier<List<BookCardState>?>(null);
  static const writtenStartMin = -3500;
  static const writtenEndMax = 2023;
  final authorAliveBetween = ValueNotifier(RangeValues(
      writtenStartMin.toDouble(),
      writtenEndMax.toDouble())
  );
  final isLoading = ValueNotifier(false);
  final topic = ValueNotifier("");
  final languageCodes = ValueNotifier(<String>[]);

  int? _nextPage = 1;

  void setSortOption(Sort option) {
    sortOption.value = option;
    _resetPagination();
  }

  void setSearchQuery(String query) {
    this.query.value = query;
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

  void setAuthorAliveBetween(RangeValues values) {
    authorAliveBetween.value = values;
    _resetPagination();
  }

  void setTopic(String topic) {
    this.topic.value = topic;
    _resetPagination();
  }

  void toggleLanguage(String code) {
    if (languageCodes.value.any((element) => element == code)) {
      languageCodes.value = [...languageCodes.value]..remove(code);
    } else {
      languageCodes.value = [...languageCodes.value, code];
    }
    _resetPagination();
  }

  void setLanguages(List<String> codes) {
    languageCodes.value = codes;
    _resetPagination();
  }

  void loadNextPage() async {
    final page = _nextPage;
    if (page == null || isLoading.value) return;

    isLoading.value = true;

    final newBooks = await searchBooksUseCase.search(
      query: query.value, 
      sortOption: sortOption.value,
      copyrightOptions: copyrightOptions.value,
      writtenStart: authorAliveBetween.value.start.round(),
      writtenEnd: authorAliveBetween.value.end.round(),
      topic: topic.value,
      languageCodes: languageCodes.value,
      page: page
    );
    if (newBooks != null) {
      final pageOfBookCards = newBooks.results.map((b) => BookCardState.fromEntity(entity: b)).toList();
      results.value = [...?page == 1 ? null : results.value, ...pageOfBookCards];
      _nextPage = newBooks.next ? page + 1 : null;
    }

    isLoading.value = false;
  }

  void _resetPagination() {
    _nextPage = 1;
  }
}