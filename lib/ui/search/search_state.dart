part of 'search_bloc.dart';

enum SearchStatus {
  idle, loading, error, empty, success
}

class SearchState extends Equatable {
  final List<BookCardState> results;
  final String query;
  final SearchStatus status;
  final Sort sortOption;
  final List<Copyright> copyrightOptions;
  final int writtenStart;
  final int writtenEnd;
  final String topic;
  final List<Language> languages;

  const SearchState._({
    required this.query,
    required this.results,
    required this.status,
    required this.sortOption,
    required this.copyrightOptions,
    required this.writtenStart,
    required this.writtenEnd,
    required this.topic,
    required this.languages
  }) : super();

  const SearchState.initial() : this._(
    query: '',
    results: const [],
    status: SearchStatus.idle,
    sortOption: Sort.popular,
    copyrightOptions: Copyright.values,
    writtenStart: -3500,
    writtenEnd: 2023,
    topic: '',
    languages: const []
  );

  SearchState copyWith({
    String? query,
    List<BookCardState>? results,
    SearchStatus? status,
    Sort? sortOption,
    List<Copyright>? copyrightOptions,
    int? writtenStart,
    int? writtenEnd,
    String? topic,
    List<Language>? languages
  }) => SearchState._(
    query: query ?? this.query,
    results: results ?? this.results,
    status: status ?? this.status,
    sortOption: sortOption ?? this.sortOption,
    copyrightOptions: copyrightOptions ?? this.copyrightOptions,
    writtenStart: writtenStart ?? this.writtenStart,
    writtenEnd: writtenEnd ?? this.writtenEnd,
    topic: topic ?? this.topic,
    languages: languages ?? this.languages
  );

  @override
  List<Object?> get props => [
    results, status, sortOption, copyrightOptions,
    writtenStart, writtenEnd, topic, languages
  ];
}