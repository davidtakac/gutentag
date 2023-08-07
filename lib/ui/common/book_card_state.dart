import 'package:gutentag/domain/books.dart';

class BookCardState {
  final String id;
  final String title;
  final String authors;
  final String languages;
  final String subjects;
  final String? coverUrl;

  const BookCardState({
    required this.id,
    required this.title,
    required this.authors,
    required this.languages,
    required this.subjects,
    required this.coverUrl
  });

  BookCardState.fromEntity({required Book entity}) : this(
    id: entity.id,
    title: entity.title, 
    authors: entity.authors.map((a) => a.shortName).join(', '), 
    languages: entity.languages.map((e) => e.name).join(', '),
    subjects: entity.subjects.join(', '),
    coverUrl: entity.coverUrl
  );

  @override
  bool operator ==(Object other) => 
    other is BookCardState && other.id == id && other.title == title && other.authors == authors && other.languages == languages && other.subjects == subjects && other.coverUrl == coverUrl;

  @override
  int get hashCode => 
    id.hashCode * title.hashCode * authors.hashCode * languages.hashCode * subjects.hashCode * coverUrl.hashCode;
}