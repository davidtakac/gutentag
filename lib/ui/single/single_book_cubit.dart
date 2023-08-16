import 'package:bloc/bloc.dart';
import 'package:gutentag/domain/use_case/get_single_book_use_case.dart';
import 'package:gutentag/ui/single/single_book_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SingleBookCubit extends Cubit<SingleBookState> {
  final GetSingleBookUseCase _getBookUseCase;

  SingleBookCubit(this._getBookUseCase) : super(const SingleBookState.initial());

  void getBook(String id) async {
    if (state.status == SingleBookStatus.success) return;

    emit(state.copyWith(status: SingleBookStatus.loading));
    final book = await _getBookUseCase.getBook(id: id);
    if (book == null) {
      emit(state.copyWith(status: SingleBookStatus.error));
    } else {
      emit(state.copyWith(
        status: SingleBookStatus.success,
        title: book.title,
        coverUrl: book.coverUrl,
        authors: book.authors.map((a) => a.fullName).join(', '),
        translators: book.translators.map((t) => t.fullName).join(', '),
        subjects: book.subjects.join(', '),
        downloadCount: book.downloadCount,
        html5Url: book.downloads.html5,
        epub3Url: book.downloads.epub3,
        kindleUrl: book.downloads.kindle,
        plainTextUrl: book.downloads.plainText));
    }
  }
}
