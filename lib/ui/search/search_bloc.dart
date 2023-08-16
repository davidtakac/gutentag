import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gutentag/domain/copyright.dart';
import 'package:gutentag/domain/language.dart';
import 'package:gutentag/domain/sort.dart';
import 'package:gutentag/domain/use_case/search_use_case.dart';
import 'package:gutentag/ui/common/book_card_state.dart';
import 'package:injectable/injectable.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;
  int? _nextPage;

  String _query = "";
  String _topic = "";
  Sort _sortOption = Sort.popular;
  List<Copyright> _copyrightOptions = Copyright.values;
  int _writtenStart = -3500;
  int _writtenEnd = 2023;
  List<Language> _languages = [];

  SearchBloc(this._searchUseCase) : super(const SearchState.initial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SetQuery) {
        _resetPagination();
        _query = event.query;
        emit(state.copyWith(query: _query));
      } else if (event is SetTopic) {
        _resetPagination();
        _topic = event.topic;
        emit(state.copyWith(topic: _topic));
      } else if (event is SetSortOption) {
        _resetPagination();
        _sortOption = event.sortOption;
        emit(state.copyWith(sortOption: _sortOption));
        emit(await _search(_nextPage!));
      } else if (event is ToggleCopyrightOption) {
        _resetPagination();
        final newCopyrightOptions = [..._copyrightOptions];
        if (_copyrightOptions.any((element) => element == event.copyrightOption)) {
          newCopyrightOptions.remove(event.copyrightOption);
        } else {
          newCopyrightOptions.add(event.copyrightOption);
        }
        _copyrightOptions = newCopyrightOptions;
        emit(state.copyWith(copyrightOptions: _copyrightOptions));
      } else if (event is SetWrittenBetween) {
        _resetPagination();
        _writtenStart = event.writtenStart;
        _writtenEnd = event.writtenEnd;
        emit(
          state.copyWith(
            writtenStart: _writtenStart,
            writtenEnd: _writtenEnd
          )
        );
      } else if (event is ToggleLanguage) {
        _resetPagination();
        final newLanguages = [..._languages];
        if (_languages.any((element) => element == event.language)) {
          newLanguages.remove(event.language);
        } else {
          newLanguages.add(event.language);
        }
        _languages = newLanguages;
        emit(state.copyWith(languages: _languages));
      } else if (event is SetLanguages) {
        _resetPagination();
        _languages = event.languages;
        emit(state.copyWith(languages: _languages));
      } else if (
        event is LoadMore
          && _nextPage != null
          && state.status != SearchStatus.loading
      ) {
        emit(state.copyWith(status: SearchStatus.loading));
        _nextPage = _nextPage! + 1;
        emit(await _search(_nextPage!));
      } else if (event is Search) {
        _resetPagination();
        emit(state.copyWith(status: SearchStatus.loading));
        emit(await _search(_nextPage!));
      }
    });
  }

  Future<SearchState> _search(int page) async {
    final books = await _searchUseCase.search(
        query: _query,
        sortOption: _sortOption,
        copyrightOptions: _copyrightOptions,
        writtenStart: _writtenStart,
        writtenEnd: _writtenEnd,
        languages: _languages,
        page: page
    );

    if (books == null) {
      return state.copyWith(status: SearchStatus.error);
    } else {
      _nextPage = books.next ? page + 1 : null;
      final newPage = books.results
          .map((e) => BookCardState.fromEntity(entity: e))
          .toList();

      final newResults = <BookCardState>[];
      if (page == 1) {
        newResults.addAll(newPage);
      } else {
        newResults.addAll(state.results);
        newResults.addAll(newPage);
      }

      return state.copyWith(
        status: newResults.isEmpty
            ? SearchStatus.empty
            : SearchStatus.success,
        results: newResults
      );
    }
  }

  void _resetPagination() => _nextPage = 1;
}
