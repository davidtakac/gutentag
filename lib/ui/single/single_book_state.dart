class SingleBookState {
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
  int get hashCode => 
    title.hashCode * authors.hashCode 
      * translators.hashCode * coverUrl.hashCode
      * subjects.hashCode * downloadCount.hashCode
      * html5Url.hashCode * epub3Url.hashCode
      * kindleUrl.hashCode * plainTextUrl.hashCode;

  @override
  bool operator ==(Object other) =>
    other is SingleBookState
      && other.title == title && other.authors == authors 
      && other.coverUrl == coverUrl && other.translators == translators 
      && other.subjects == subjects && other.downloadCount == downloadCount
      && other.html5Url == html5Url && other.epub3Url == epub3Url 
      && other.kindleUrl == kindleUrl && other.plainTextUrl == plainTextUrl;
}