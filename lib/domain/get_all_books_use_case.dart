import 'package:gutentag/domain/books.dart';
import 'package:gutentag/domain/copyright_options.dart';
import 'package:gutentag/domain/search_books_use_case.dart';
import 'package:gutentag/domain/sort_options.dart';

class GetMostPopularBooksUseCase {
  const GetMostPopularBooksUseCase({required this.searchBooksUseCase});

  final SearchBooksUseCase searchBooksUseCase;

  Future<Books?> getAllBooks({int page = 1}) async => searchBooksUseCase.search(
      query: '',
      sortOption: Sort.popular,
      copyrightOptions: Copyright.values,
      writtenStart: -3500,
      writtenEnd: 2023,
      topic: '',
      languageCodes: [],
      page: page
  );
}