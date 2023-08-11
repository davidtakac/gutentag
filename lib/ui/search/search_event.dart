part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SetQuery extends SearchEvent {
  final String query;

  const SetQuery(this.query);

  @override
  List<Object?> get props => [query];
}

class SetTopic extends SearchEvent {
  final String topic;

  const SetTopic(this.topic);

  @override
  List<Object?> get props => [topic];
}

class SetSortOption extends SearchEvent {
  final Sort sortOption;

  const SetSortOption(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

class ToggleCopyrightOption extends SearchEvent {
  final Copyright copyrightOption;

  const ToggleCopyrightOption(this.copyrightOption);

  @override
  List<Object?> get props => [copyrightOption];
}

class SetWrittenBetween extends SearchEvent {
  final int writtenStart;
  final int writtenEnd;

  const SetWrittenBetween(this.writtenStart, this.writtenEnd);

  @override
  List<Object?> get props => [writtenStart, writtenEnd];
}

class ToggleLanguage extends SearchEvent {
  final Language language;

  const ToggleLanguage(this.language);

  @override
  List<Object?> get props => [language];
}

class SetLanguages extends SearchEvent {
  final List<Language> languages;

  const SetLanguages(this.languages);

  @override
  List<Object?> get props => [languages];
}

class LoadMore extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class Search extends SearchEvent {
  @override
  List<Object?> get props => [];
}