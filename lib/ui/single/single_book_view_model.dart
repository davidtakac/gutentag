import 'package:flutter/material.dart';
import 'package:gutentag/domain/use_case/get_single_book_use_case.dart';
import 'package:gutentag/ui/single/single_book_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SingleBookViewModel {
  final GetSingleBookUseCase getBookUseCase;
  SingleBookViewModel({required this.getBookUseCase,});

  ValueNotifier<SingleBookState?> state = ValueNotifier(null);

  void getBook(String id) async {
    if (state.value != null) return;

    final details = await getBookUseCase.getBook(id: id);
    if (details == null) return;

    state.value = SingleBookState(
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

  void dispose() {
    state.dispose();
  }
}