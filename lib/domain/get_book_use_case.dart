import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/books.dart';

class GetBookUseCase {
  final ApiService _apiService;

  const GetBookUseCase({required ApiService apiService}) : _apiService = apiService;

  Future<Book?> getBook({required String id}) async => _apiService.getBook(id: id);
}