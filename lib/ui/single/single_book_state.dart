import 'package:equatable/equatable.dart';

enum SingleBookStatus {
  idle, loading, success, error;
}

class SingleBookState extends Equatable {
  final SingleBookStatus status;
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

  const SingleBookState._({
    required this.status,
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

  const SingleBookState.initial() : this._(
    status: SingleBookStatus.idle,
    title: '',
    coverUrl: null,
    authors: '',
    translators: '',
    subjects: '',
    downloadCount: 0,
    html5Url: null,
    epub3Url: null,
    kindleUrl: null,
    plainTextUrl: null,
  );

  SingleBookState copyWith({
    SingleBookStatus? status,
    String? title,
    String? coverUrl,
    String? authors,
    String? translators,
    String? subjects,
    int? downloadCount,
    String? html5Url,
    String? epub3Url,
    String? kindleUrl,
    String? plainTextUrl,
  }) => SingleBookState._(
    status: status ?? this.status,
    title: title ?? this.title,
    coverUrl: coverUrl ?? this.coverUrl,
    authors: authors ?? this.authors,
    translators: translators ?? this.translators,
    subjects: subjects ?? this.subjects,
    downloadCount: downloadCount ?? this.downloadCount,
    html5Url: html5Url ?? this.html5Url,
    epub3Url: epub3Url ?? this.epub3Url,
    kindleUrl: kindleUrl ?? this.kindleUrl,
    plainTextUrl: plainTextUrl ?? this.plainTextUrl,
  );

  @override
  List<Object?> get props => [
    title, coverUrl, authors, translators,
    subjects, downloadCount, html5Url, epub3Url,
    kindleUrl, plainTextUrl
  ];
}