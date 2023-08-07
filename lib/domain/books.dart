import 'package:gutentag/domain/language.dart';

class Books {
  final bool next;
  final List<Book> results;

  const Books({
    required this.next,
    required this.results
  });
}

class Book {
  final String id;
  final String title;
  final String? coverUrl;
  final List<Person> authors;
  final List<Person> translators;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<Language> languages;
  final bool copyright;
  final Downloads downloads;
  final int downloadCount;

  const Book({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.downloads,
    required this.downloadCount
  });
}

class Person {
  final String fullName;
  final String shortName;
  final int? birthYear;
  final int? deathYear;

  Person({
    required this.fullName,
    required this.birthYear,
    this.deathYear
  }) : shortName = fullName.replaceAll(RegExp('\\s\\(.*\\)'), '');
}

class Downloads {
  final String? html5;
  final String? epub3;
  final String? kindle;
  final String? plainText;
  
  const Downloads({
    this.html5,
    this.epub3,
    this.kindle,
    this.plainText
  });
}