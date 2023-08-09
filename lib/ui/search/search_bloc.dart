import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:gutentag/di/injection.dart';
import 'package:gutentag/domain/books.dart';
import 'package:gutentag/domain/copyright.dart';
import 'package:gutentag/domain/language.dart';
import 'package:gutentag/domain/sort.dart';
import 'package:gutentag/domain/use_case/search_use_case.dart';
import 'package:gutentag/ui/common/book_card_state.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;

  SearchBloc(this._searchUseCase) : super(const SearchState.initial()) {
    on<SearchEvent>((event, emit) async {
      if (event is Search) {
        emit(SearchState.loading(state));

        final results = await _searchUseCase.search(
          query: event.query,
          sortOption: event.sortBy,
          copyrightOptions: event.copyrightOptions,
          writtenStart: event.writtenStart,
          writtenEnd: event.writtenEnd,
          languages: event.languages,
          page: event.page
        );

        if (results == null) {
          emit(const SearchState.error());
        } else if (results.results.isEmpty) {
          emit(const SearchState.empty());
        } else {
          emit(const SearchState.success(
            [],
            results.next ? event.page + 1 : null
          ));
        }
        return SearchResults(results: results, isLoading: isLoading, isEmpty: isEmpty, isError: isError)
      }
    });
  }
}
