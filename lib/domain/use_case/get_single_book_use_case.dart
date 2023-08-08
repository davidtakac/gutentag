import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/books.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSingleBookUseCase {
  final ApiService _apiService;
  const GetSingleBookUseCase({required ApiService apiService}) : _apiService = apiService;

  Future<Book?> getBook({required String id}) async => _apiService.getBook(id: id);
}