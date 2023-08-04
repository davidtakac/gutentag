import 'package:flutter/material.dart';
import 'package:gutentag/domain/get_book_use_case.dart';
import 'package:gutentag/presentation/book_state.dart';

class BookViewModel {
  BookViewModel({
    required GetBookUseCase getBookUseCase,
  }) : _getBookUseCase = getBookUseCase;

  final GetBookUseCase _getBookUseCase;
  ValueNotifier<BookState?> state = ValueNotifier(null);

  void getBook(String id) async {
    if (state.value != null) return;

    final details = await _getBookUseCase.getBook(id: id);
    if (details == null) return;

    state.value = BookState(
      title: details.title, 
      coverUrl: details.coverUrl,
      authors: details.authors.map((a) => a.fullName).join(', '), 
      translators: details.translators.map((t) => t.fullName).join(', '),
      subjects: details.subjects.join(', '), 
      downloadCount: details.downloadCount, 
      html5Url: details.downloads.html5,
      epub3Url: details.downloads.epub3,
      kindleUrl: details.downloads.kindle,
      plainTextUrl: details.downloads.plainText
    );
  }
}