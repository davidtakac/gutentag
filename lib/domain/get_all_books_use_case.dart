import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/books.dart';

class GetAllBooksUseCase {
  const GetAllBooksUseCase({required apiService}) : _apiService = apiService;

  final ApiService _apiService;

  Future<Books?> getAllBooks({int page = 1}) async => _apiService.getAllBooks(page: page);
}