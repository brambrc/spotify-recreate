part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}

class LibraryInitialState extends LibraryState {}

class LibraryLoadingState extends LibraryState {}

class LibraryLoadedState extends LibraryState {
  final List<dynamic> allItems; // Can contain Playlist, Artist, Album
  final List<dynamic> filteredItems;
  final LibraryFilter selectedFilter;
  final LibraryViewType viewType;
  final LibrarySortType sortType;
  final List<Track> likedSongs;

  const LibraryLoadedState({
    required this.allItems,
    required this.filteredItems,
    required this.selectedFilter,
    required this.viewType,
    required this.sortType,
    required this.likedSongs,
  });

  @override
  List<Object> get props => [
        allItems,
        filteredItems,
        selectedFilter,
        viewType,
        sortType,
        likedSongs,
      ];
}

class LibraryErrorState extends LibraryState {
  final String message;

  const LibraryErrorState(this.message);

  @override
  List<Object> get props => [message];
}

