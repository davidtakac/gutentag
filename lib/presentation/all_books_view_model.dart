import 'package:flutter/material.dart';
import 'package:gutentag/domain/get_all_books_use_case.dart';
import 'package:gutentag/presentation/all_books_state.dart';

class AllBooksViewModel {
  AllBooksViewModel({
    required this.getMostPopularBooksUseCase
  });

  GetMostPopularBooksUseCase getMostPopularBooksUseCase;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<List<BookCardState>> books = ValueNotifier([]);

  int? _nextPage = 1;

  void getNextPage() async {
    final page = _nextPage;
    if (page == null || isLoading.value) return;

    isLoading.value = true;

    final newBooks = await getMostPopularBooksUseCase.getAllBooks(page: page);
    if (newBooks != null) {
      final pageOfBookCards = newBooks.results.map((b) => BookCardState.fromEntity(entity: b)).toList();
      books.value = books.value + pageOfBookCards;
      _nextPage = newBooks.next ? page + 1 : null;
    }

    isLoading.value = false;
  }
}