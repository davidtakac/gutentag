import 'package:flutter/material.dart';
import 'package:gutentag/domain/copyright_options.dart';
import 'package:gutentag/domain/search_books_use_case.dart';
import 'package:gutentag/domain/sort_options.dart';
import 'package:gutentag/presentation/all_books_state.dart';

class BookSearchViewModel {
  final SearchBooksUseCase _searchBooksUseCase;

  BookSearchViewModel({required SearchBooksUseCase searchBooksUseCase})
      : _searchBooksUseCase = searchBooksUseCase;

  final sortOption = ValueNotifier(Sort.popular);
  final query = ValueNotifier("");
  final copyrightOptions = ValueNotifier(Copyright.values);
  final results = ValueNotifier<List<BookCardState>?>(null);
  static const authorAliveEarliest = -3500;
  static const authorAliveLatest = 2023;
  final authorAliveBetween = ValueNotifier(RangeValues(
      authorAliveEarliest.toDouble(),
      authorAliveLatest.toDouble())
  );
  final loading = ValueNotifier(false);
  final topic = ValueNotifier("");
  final ValueNotifier<List<String>> languageCodes = ValueNotifier([]);

  void setSortOption(Sort option) {
    sortOption.value = option;
  }

  void setSearchQuery(String query) {
    this.query.value = query;
  }

  void toggleCopyrightOption(Copyright option) {
    if (copyrightOptions.value.any((element) => element == option)) {
      copyrightOptions.value = [...copyrightOptions.value]..remove(option);
    } else {
      copyrightOptions.value = [...copyrightOptions.value, option];
    }
  }

  void setAuthorAliveBetween(RangeValues values) {
    authorAliveBetween.value = values;
  }

  void setTopic(String topic) {
    this.topic.value = topic;
  }

  void toggleLanguage(String code) {
    if (languageCodes.value.any((element) => element == code)) {
      languageCodes.value = [...languageCodes.value]..remove(code);
    } else {
      languageCodes.value = [...languageCodes.value, code];
    }
  }

  void setLanguages(List<String> codes) {
    this.languageCodes.value = codes;
  }

  void search() async {
    loading.value = true;
    final results = await _searchBooksUseCase.search(
      query: query.value, 
      sortOption: sortOption.value,
      copyrightOptions: copyrightOptions.value,
      authorAliveEarliest: authorAliveBetween.value.start.round(),
      authorAliveLatest: authorAliveBetween.value.end.round(),
      topic: topic.value,
      languageCodes: languageCodes.value
    );
    loading.value = false;
    if (results != null) {
      this.results.value = results.map((e) => BookCardState.fromEntity(entity: e)).toList();
    }
  }
}