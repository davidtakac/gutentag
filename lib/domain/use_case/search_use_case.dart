import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/books.dart';
import 'package:gutentag/domain/copyright.dart';
import 'package:gutentag/domain/sort.dart';

class SearchUseCase {
  const SearchUseCase({required ApiService apiService}) : _apiService = apiService;

  final ApiService _apiService;

  Future<Books?> search({
    String query = "",
    Sort sortOption = Sort.popular,
    List<Copyright> copyrightOptions = Copyright.values,
    int writtenStart = -3500,
    int writtenEnd = 2023,
    String topic = "",
    List<String> languageCodes = const [],
    int page = 1
  }) => _apiService.searchBooks(
      query,
      sortOption,
      copyrightOptions,
      writtenStart,
      writtenEnd,
      topic,
      languageCodes,
      page
  );
}