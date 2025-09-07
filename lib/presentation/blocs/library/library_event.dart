part of 'library_bloc.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

class LibraryLoadDataEvent extends LibraryEvent {}

class LibraryFilterChangedEvent extends LibraryEvent {
  final LibraryFilter filter;

  const LibraryFilterChangedEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class LibraryViewTypeChangedEvent extends LibraryEvent {
  final LibraryViewType viewType;

  const LibraryViewTypeChangedEvent(this.viewType);

  @override
  List<Object> get props => [viewType];
}

class LibrarySortTypeChangedEvent extends LibraryEvent {
  final LibrarySortType sortType;

  const LibrarySortTypeChangedEvent(this.sortType);

  @override
  List<Object> get props => [sortType];
}

