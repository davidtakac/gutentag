import 'package:gutentag/domain/books.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books_response.g.dart';

@JsonSerializable()
class BooksResponse {
  final String? next;
  final List<BookResponse> results;

  const BooksResponse({
    required this.next,
    required this.results
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) => _$BooksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BooksResponseToJson(this);

  Books toBooks() => Books(
    next: next != null, 
    results: results.map((r) => r.toBook()).toList()
  );
}

@JsonSerializable()
class BookResponse {
  final int id;
  final String title;
  final List<PersonResponse> authors;
  final List<PersonResponse> translators;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  final FormatsResponse formats;
  @JsonKey(name: 'download_count')
  final int downloadCount;

  const BookResponse({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.formats,
    required this.downloadCount
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) => _$BookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookResponseToJson(this);

  Book toBook() => Book(
    id: id.toString(), 
    title: title, 
    coverUrl: formats.coverUrl,
    authors: authors.map((a) => a.toPerson()).toList(),
    translators: translators.map((t) => t.toPerson()).toList(), 
    subjects: subjects, 
    bookshelves: bookshelves, 
    languages: languages, 
    copyright: copyright, 
    downloads: formats.toDownloads(), 
    downloadCount: downloadCount
  );
}

@JsonSerializable()
class PersonResponse {
  final String name;
  @JsonKey(name: 'birth_year')
  final int? birthYear;
  @JsonKey(name: 'death_year')
  final int? deathYear;

  const PersonResponse({
    required this.name,
    required this.birthYear,
    this.deathYear
  });

  factory PersonResponse.fromJson(Map<String, dynamic> json) => _$PersonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);

  Person toPerson() => Person(
    fullName: name.split(', ').reversed.join(' '), 
    birthYear: birthYear, 
    deathYear: deathYear,
  );
}

@JsonSerializable()
class FormatsResponse {
  @JsonKey(name: 'text/plain')
  final String? plainTextUrl;  

  @JsonKey(name: 'application/x-mobipocket-ebook')
  final String? mobiUrl;

  @JsonKey(name: 'text/html')
  final String? htmlUrl;
  
  @JsonKey(name: 'application/octet-stream')
  final String? octetStreamUrl;

  @JsonKey(name: 'text/plain; charset=us-ascii')
  final String? plainTextAsciiUrl;

  @JsonKey(name: 'application/epub+zip')
  final String? epubUrl;

  @JsonKey(name: 'image/jpeg')
  final String? coverUrl;

  @JsonKey(name: 'application/rdf+xml')
  final String? rdfUrl;

  @JsonKey(name: 'text/html; charset=iso-8859-1')
  final String? htmlIso88591Url;

  @JsonKey(name: 'text/html; charset=utf-8')
  final String? htmlUtf8Url;

  @JsonKey(name: 'text/plain; charset=utf-8')
  final String? plainTextUtf8Url;

  @JsonKey(name: 'text/plain; charset=iso-8859-1')
  final String? plainTextIso88591Url;

  const FormatsResponse({
    this.plainTextUrl,
    this.mobiUrl,
    this.htmlUrl,
    this.octetStreamUrl,
    this.plainTextAsciiUrl,
    this.epubUrl,
    this.coverUrl,
    this.rdfUrl,
    this.htmlIso88591Url,
    this.htmlUtf8Url,
    this.plainTextUtf8Url,
    this.plainTextIso88591Url
  });

  factory FormatsResponse.fromJson(Map<String, dynamic> json) => _$FormatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FormatsResponseToJson(this);

  Downloads toDownloads() => Downloads(
    plainText: plainTextUrl,
    kindle: mobiUrl,
    html5: htmlUrl,
    epub3: epubUrl,
  );
}