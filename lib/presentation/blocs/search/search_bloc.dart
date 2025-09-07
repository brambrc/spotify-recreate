import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/track.dart';
import '../../../domain/models/artist.dart';
import '../../../domain/models/album.dart';
import '../../../domain/models/playlist.dart';
import '../../../domain/models/user.dart';
import '../../../data/services/discogs_api_service.dart';
import '../../../data/services/mock_data_service.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DiscogsApiService _discogsApiService;
  final MockDataService _mockDataService = MockDataService.instance;

  SearchBloc(this._discogsApiService) : super(SearchInitialState()) {
    on<SearchQueryChangedEvent>(_onQueryChanged);
    on<SearchPerformedEvent>(_onSearchPerformed);
    on<SearchClearEvent>(_onClearSearch);
    on<SearchLoadGenresEvent>(_onLoadGenres);
  }

  void _onQueryChanged(SearchQueryChangedEvent event, Emitter<SearchState> emit) {
    if (event.query.isEmpty) {
      emit(SearchInitialState(
        genres: _mockDataService.genres,
        recentSearches: _mockDataService.recentSearches,
      ));
    }
    // Could implement debounced search here
  }

  void _onSearchPerformed(SearchPerformedEvent event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      emit(SearchInitialState(
        genres: _mockDataService.genres,
        recentSearches: _mockDataService.recentSearches,
      ));
      return;
    }

    emit(SearchLoadingState());

    try {
      // Add query to recent searches
      _mockDataService.addToRecentSearches(event.query);
      
      // Use comprehensive mock data service for search
      final searchTracks = _mockDataService.searchTracks(event.query);
      final searchArtists = _mockDataService.searchArtists(event.query);
      final searchAlbums = _mockDataService.searchAlbums(event.query);
      final searchPlaylists = _mockDataService.searchPlaylists(event.query);
      
      print('Search results: ${searchTracks.length} tracks, ${searchArtists.length} artists, ${searchAlbums.length} albums, ${searchPlaylists.length} playlists');
      
      emit(SearchResultsState(
        query: event.query,
        tracks: searchTracks,
        artists: searchArtists,
        albums: searchAlbums,
        playlists: searchPlaylists,
      ));
    } catch (e) {
      print('Search error: $e');
      emit(SearchErrorState('Failed to search. Please try again.'));
    }
  }

  void _onLoadGenres(SearchLoadGenresEvent event, Emitter<SearchState> emit) {
    emit(SearchInitialState(
      genres: _mockDataService.genres,
      recentSearches: _mockDataService.recentSearches,
    ));
  }

  void _onClearSearch(SearchClearEvent event, Emitter<SearchState> emit) {
    emit(SearchInitialState(
      genres: _mockDataService.genres,
      recentSearches: _mockDataService.recentSearches,
    ));
  }
}
