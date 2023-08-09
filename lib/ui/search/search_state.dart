part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<BookCardState> results;
  final bool isLoading;
  final bool isEmpty;
  final bool isError;
  final int? nextPage;

  const SearchState._({
    required this.results,
    required this.isLoading,
    required this.isEmpty,
    required this.isError,
    required this.nextPage
  }) : super();

  const SearchState.initial() : this._(
      results: const [],
      isLoading: false,
      isEmpty: false,
      isError: false,
      nextPage: 1
  );

  SearchState.loading(SearchState currentState) : this._(
      results: currentState.results,
      isEmpty: currentState.isEmpty,
      isError: currentState.isError,
      nextPage: currentState.nextPage,
      isLoading: true
  );

  const SearchState.empty() : this._(
      results: const [],
      isLoading: false,
      isEmpty: true,
      isError: false,
      nextPage: 1
  );

  const SearchState.error() : this._(
      results: const [],
      isLoading: false,
      isEmpty: false,
      isError: true,
      nextPage: 1
  );

  const SearchState.success(
    List<BookCardState> results,
    int? nextPage,
  ) : this._(
      results: results,
      isLoading: false,
      isEmpty: false,
      isError: false,
      nextPage: nextPage
  );

  @override
  List<Object?> get props => [results, isLoading, isEmpty, isError, nextPage];
}