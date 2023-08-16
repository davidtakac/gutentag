import 'package:equatable/equatable.dart';

class SingleBookState extends Equatable {
  final String title;
  final String? coverUrl;
  final String authors;
  final String translators;
  final String subjects;
  final int downloadCount;
  final String? html5Url;
  final String? epub3Url;
  final String? kindleUrl; 
  final String? plainTextUrl;

  const SingleBookState({
    required this.title,
    required this.coverUrl,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.downloadCount,
    required this.html5Url,
    required this.epub3Url,
    required this.kindleUrl,
    required this.plainTextUrl
  });

  @override
  List<Object?> get props => [
    title, coverUrl, authors, translators,
    subjects, downloadCount, html5Url, epub3Url,
    kindleUrl, plainTextUrl
  ];
}