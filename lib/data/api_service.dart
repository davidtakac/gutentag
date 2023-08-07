import 'dart:convert';

import 'package:gutentag/data/books_response.dart';
import 'package:gutentag/domain/books.dart';
import 'package:gutentag/domain/copyright.dart';
import 'package:gutentag/domain/language.dart';
import 'package:gutentag/domain/sort.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _url = 'https://gutendex.com/books';

  Future<Book?> getBook({required String id}) async {
    final response = await http.get(Uri.parse('$_url/$id'));
    if (response.statusCode != 200) return null;
    return BookResponse.fromJson(jsonDecode(response.body)).toBook();
  }

  Future<Books?> searchBooks(
      String query,
      Sort sortOption,
      List<Copyright> copyrightOptions,
      int authorAliveEarliest,
      int authorAliveLatest,
      String topic,
      List<Language> languages,
      int page
  ) async {
    final response = await http.get(Uri.parse('$_url'
        '?sort=${_mapSortToServerString(sortOption)}'
        '&search=$query'
        '&copyright=${_mapCopyrightListToServerString(copyrightOptions)}'
        '&author_year_start=$authorAliveEarliest'
        '&author_year_end=$authorAliveLatest'
        '&topic=$topic'
        '${languages.isEmpty ? '' : '&languages=${_mapLanguageListToServerString(languages)}'}'
        '&page=$page'
    ));
    if (response.statusCode != 200) {
      return null;
    } else {
      return BooksResponse.fromJson(jsonDecode(response.body)).toBooks();
    }
  }

  String _mapSortToServerString(Sort sort) {
    switch(sort) {
      case Sort.ascending: return 'ascending';
      case Sort.descending: return 'descending';
      default: return 'popular';
    }
  }

  String _mapCopyrightListToServerString(List<Copyright> copyrightOptions) {
    return copyrightOptions.map((e) {
      switch(e) {
        case Copyright.yes: return 'true';
        case Copyright.no: return 'false';
        default: return 'null';
      }
    }).join(',');
  }

  String _mapLanguageListToServerString(List<Language> languages) {
    return languages.map((e) => e.code).join(',');
  }
}