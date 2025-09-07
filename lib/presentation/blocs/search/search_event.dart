part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryChangedEvent extends SearchEvent {
  final String query;

  const SearchQueryChangedEvent(this.query);

  @override
  List<Object> get props => [query];
}

class SearchPerformedEvent extends SearchEvent {
  final String query;

  const SearchPerformedEvent(this.query);

  @override
  List<Object> get props => [query];
}

class SearchClearEvent extends SearchEvent {}

class SearchLoadGenresEvent extends SearchEvent {}

