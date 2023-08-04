import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/books.dart';
import 'package:gutentag/domain/copyright_options.dart';
import 'package:gutentag/domain/sort_options.dart';

class SearchBooksUseCase {
  const SearchBooksUseCase({required ApiService apiService}) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<Book>?> search({
    String query = "",
    Sort sortOption = Sort.popular,
    List<Copyright> copyrightOptions = Copyright.values,
    int authorAliveEarliest = -3500,
    int authorAliveLatest = 2023,
    String topic = "",
  }) => _apiService.searchBooks(
      query,
      sortOption,
      copyrightOptions,
      authorAliveEarliest,
      authorAliveLatest,
      topic
  );
}