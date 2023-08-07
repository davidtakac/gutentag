import 'dart:convert';

import 'package:gutentag/data/books_response.dart';
import 'package:gutentag/domain/books.dart';
import 'package:gutentag/domain/copyright_options.dart';
import 'package:gutentag/domain/sort_options.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _url = 'https://gutendex.com/books';

  Future<Books?> getAllBooks({int page = 1}) async {
    if (page < 1) throw Exception('Page must be greater than 0.');
    final response = await http.get(Uri.parse('$_url?page=$page'));
    if (response.statusCode != 200) return null;
    return BooksResponse.fromJson(jsonDecode(response.body)).toBooks();
  }

  Future<Book?> getBook({required String id}) async {
    final response = await http.get(Uri.parse('$_url/$id'));
    if (response.statusCode != 200) return null;
    return BookResponse.fromJson(jsonDecode(response.body)).toBook();
  }

  Future<List<Book>?> searchBooks(
      String query,
      Sort sortOption,
      List<Copyright> copyrightOptions,
      int authorAliveEarliest,
      int authorAliveLatest,
      String topic,
      List<String> languageCodes
  ) async {
    final String sortOptionString;
    switch(sortOption) {
      case Sort.ascending: sortOptionString = 'ascending';
      case Sort.descending: sortOptionString = 'descending';
      default: sortOptionString = 'popular';
    }
    final String copyrightOptionsString = copyrightOptions.map((e) { 
      switch(e) {
        case Copyright.yes: return 'true';
        case Copyright.no: return 'false';
        default: return 'null';
      }
    }).join(',');
    final response = await http.get(Uri.parse('$_url'
        '?sort=$sortOptionString'
        '&search=$query'
        '&copyright=$copyrightOptionsString'
        '&authorStartYear=$authorAliveEarliest'
        '&authorEndYear=$authorAliveLatest'
        '&topic=$topic'
        '${languageCodes.isEmpty ? '' : '&languages=${languageCodes.join(',')}'}'
    ));
    if (response.statusCode != 200) return null;
    return BooksResponse.fromJson(jsonDecode(response.body)).toBooks().results;
  }
}