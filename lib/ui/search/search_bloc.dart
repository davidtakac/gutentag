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

  SearchBloc(this._searchUseCase) : super(const SearchState.initial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SetQuery) {
        _resetPagination();
        emit(state.copyWith(query: event.query));
      } else if (event is SetTopic) {
        _resetPagination();
        emit(state.copyWith(topic: event.topic));
      } else if (event is SetSortOption) {
        _resetPagination();
        emit(state.copyWith(sortOption: event.sortOption));
        emit(await _search(_nextPage!));
      } else if (event is ToggleCopyrightOption) {
        _resetPagination();
        final newCopyrightOptions = [...state.copyrightOptions];
        if (state.copyrightOptions.any((element) => element == event.copyrightOption)) {
          newCopyrightOptions.remove(event.copyrightOption);
        } else {
          newCopyrightOptions.add(event.copyrightOption);
        }
        emit(state.copyWith(copyrightOptions: newCopyrightOptions));
      } else if (event is SetWrittenBetween) {
        _resetPagination();
        emit(
          state.copyWith(
            writtenStart: event.writtenStart,
            writtenEnd: event.writtenEnd
          )
        );
      } else if (event is ToggleLanguage) {
        _resetPagination();
        final newLanguages = [...state.languages];
        if (state.languages.any((element) => element == event.language)) {
          newLanguages.remove(event.language);
        } else {
          newLanguages.add(event.language);
        }
        emit(state.copyWith(languages: newLanguages));
      } else if (event is SetLanguages) {
        _resetPagination();
        emit(state.copyWith(languages: event.languages));
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
        query: state.query,
        sortOption: state.sortOption,
        copyrightOptions: state.copyrightOptions,
        writtenStart: state.writtenStart,
        writtenEnd: state.writtenEnd,
        languages: state.languages,
        page: page
    );

    if (books == null) {
      return state.copyWith(status: SearchStatus.error);
    } else {
      _nextPage = books.next ? page++ : null;
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
