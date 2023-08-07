import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/books.dart';

class GetSingleBookUseCase {
  final ApiService _apiService;

  const GetSingleBookUseCase({required ApiService apiService}) : _apiService = apiService;

  Future<Book?> getBook({required String id}) async => _apiService.getBook(id: id);
}