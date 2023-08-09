part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class Search extends SearchEvent {
  final String query;
  final String topic;
  final Sort sortBy;
  final List<Copyright> copyrightOptions;
  final List<Language> languages;
  final int writtenStart;
  final int writtenEnd;
  final int page;

  const Search({
    required this.query,
    required this.topic,
    required this.sortBy,
    required this.copyrightOptions,
    required this.languages,
    required this.writtenStart,
    required this.writtenEnd,
    required this.page
  });

  @override
  List<Object?> get props => [
    query,
    topic,
    sortBy,
    copyrightOptions,
    languages,
    writtenStart,
    writtenEnd,
    page
  ];
}