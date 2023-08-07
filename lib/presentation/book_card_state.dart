import 'package:gutentag/domain/books.dart';

class BookCardState {
  final String id;
  final String title;
  final String authors;
  final List<String> languageCodes;
  final String subjects;
  final String? coverUrl;

  const BookCardState({
    required this.id,
    required this.title,
    required this.authors,
    required this.languageCodes,
    required this.subjects,
    required this.coverUrl
  });

  BookCardState.fromEntity({required Book entity}) : this(
    id: entity.id,
    title: entity.title, 
    authors: entity.authors.map((a) => a.shortName).join(', '), 
    languageCodes: entity.languages, 
    subjects: entity.subjects.join(', '),
    coverUrl: entity.coverUrl
  );

  @override
  bool operator ==(Object other) => 
    other is BookCardState && other.id == id && other.title == title && other.authors == authors && other.languageCodes == languageCodes && other.subjects == subjects && other.coverUrl == coverUrl;

  @override
  int get hashCode => 
    id.hashCode * title.hashCode * authors.hashCode * languageCodes.hashCode * subjects.hashCode * coverUrl.hashCode;
}