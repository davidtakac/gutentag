// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksResponse _$BooksResponseFromJson(Map<String, dynamic> json) =>
    BooksResponse(
      next: json['next'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => BookResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksResponseToJson(BooksResponse instance) =>
    <String, dynamic>{
      'next': instance.next,
      'results': instance.results,
    };

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) => BookResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>)
          .map((e) => PersonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      translators: (json['translators'] as List<dynamic>)
          .map((e) => PersonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects:
          (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
      bookshelves: (json['bookshelves'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      copyright: json['copyright'] as bool,
      formats:
          FormatsResponse.fromJson(json['formats'] as Map<String, dynamic>),
      downloadCount: json['download_count'] as int,
    );

Map<String, dynamic> _$BookResponseToJson(BookResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'translators': instance.translators,
      'subjects': instance.subjects,
      'bookshelves': instance.bookshelves,
      'languages': instance.languages,
      'copyright': instance.copyright,
      'formats': instance.formats,
      'download_count': instance.downloadCount,
    };

PersonResponse _$PersonResponseFromJson(Map<String, dynamic> json) =>
    PersonResponse(
      name: json['name'] as String,
      birthYear: json['birth_year'] as int?,
      deathYear: json['death_year'] as int?,
    );

Map<String, dynamic> _$PersonResponseToJson(PersonResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
    };

FormatsResponse _$FormatsResponseFromJson(Map<String, dynamic> json) =>
    FormatsResponse(
      plainTextUrl: json['text/plain'] as String?,
      mobiUrl: json['application/x-mobipocket-ebook'] as String?,
      htmlUrl: json['text/html'] as String?,
      octetStreamUrl: json['application/octet-stream'] as String?,
      plainTextAsciiUrl: json['text/plain; charset=us-ascii'] as String?,
      epubUrl: json['application/epub+zip'] as String?,
      coverUrl: json['image/jpeg'] as String?,
      rdfUrl: json['application/rdf+xml'] as String?,
      htmlIso88591Url: json['text/html; charset=iso-8859-1'] as String?,
      htmlUtf8Url: json['text/html; charset=utf-8'] as String?,
      plainTextUtf8Url: json['text/plain; charset=utf-8'] as String?,
      plainTextIso88591Url: json['text/plain; charset=iso-8859-1'] as String?,
    );

Map<String, dynamic> _$FormatsResponseToJson(FormatsResponse instance) =>
    <String, dynamic>{
      'text/plain': instance.plainTextUrl,
      'application/x-mobipocket-ebook': instance.mobiUrl,
      'text/html': instance.htmlUrl,
      'application/octet-stream': instance.octetStreamUrl,
      'text/plain; charset=us-ascii': instance.plainTextAsciiUrl,
      'application/epub+zip': instance.epubUrl,
      'image/jpeg': instance.coverUrl,
      'application/rdf+xml': instance.rdfUrl,
      'text/html; charset=iso-8859-1': instance.htmlIso88591Url,
      'text/html; charset=utf-8': instance.htmlUtf8Url,
      'text/plain; charset=utf-8': instance.plainTextUtf8Url,
      'text/plain; charset=iso-8859-1': instance.plainTextIso88591Url,
    };
