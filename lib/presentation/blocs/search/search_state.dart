part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {
  final List<Map<String, dynamic>> genres;
  final List<String> recentSearches;

  const SearchInitialState({
    this.genres = const [],
    this.recentSearches = const [],
  });

  @override
  List<Object?> get props => [genres, recentSearches];
}

class SearchLoadingState extends SearchState {}

class SearchResultsState extends SearchState {
  final String query;
  final List<Track> tracks;
  final List<Artist> artists;
  final List<Album> albums;
  final List<Playlist> playlists;

  const SearchResultsState({
    required this.query,
    required this.tracks,
    required this.artists,
    required this.albums,
    required this.playlists,
  });

  @override
  List<Object> get props => [query, tracks, artists, albums, playlists];
}

class SearchErrorState extends SearchState {
  final String message;

  const SearchErrorState(this.message);

  @override
  List<Object> get props => [message];
}

