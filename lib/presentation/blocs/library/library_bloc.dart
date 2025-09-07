import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/playlist.dart';
import '../../../domain/models/album.dart';
import '../../../domain/models/artist.dart';
import '../../../domain/models/track.dart';
import '../../../data/services/mock_data_service.dart';

part 'library_event.dart';
part 'library_state.dart';

enum LibraryFilter { all, playlists, artists, albums, downloaded }
enum LibraryViewType { list, grid }
enum LibrarySortType { recentlyAdded, alphabetical, creator }

@injectable
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final MockDataService _mockDataService = MockDataService.instance;
  
  LibraryBloc() : super(LibraryInitialState()) {
    on<LibraryLoadDataEvent>(_onLoadData);
    on<LibraryFilterChangedEvent>(_onFilterChanged);
    on<LibraryViewTypeChangedEvent>(_onViewTypeChanged);
    on<LibrarySortTypeChangedEvent>(_onSortTypeChanged);
  }

  void _onLoadData(LibraryLoadDataEvent event, Emitter<LibraryState> emit) async {
    emit(LibraryLoadingState());

    try {
      // Load comprehensive library data from mock service
      final userPlaylists = _mockDataService.getUserPlaylists();
      final followedPlaylists = _mockDataService.getFollowedPlaylists();
      final savedAlbums = _mockDataService.albums.where((album) => album.isSaved).toList();
      final followedArtists = _mockDataService.artists.where((artist) => artist.isFollowing).toList();
      
      // Combine all library items
      final allItems = <dynamic>[
        ...userPlaylists,
        ...followedPlaylists,
        ...savedAlbums,
        ...followedArtists,
      ];

      emit(LibraryLoadedState(
        allItems: allItems,
        filteredItems: allItems,
        selectedFilter: LibraryFilter.all,
        viewType: LibraryViewType.list,
        sortType: LibrarySortType.recentlyAdded,
        likedSongs: _mockDataService.getSavedTracks(),
      ));
    } catch (e) {
      emit(LibraryErrorState(e.toString()));
    }
  }

  void _onFilterChanged(LibraryFilterChangedEvent event, Emitter<LibraryState> emit) {
    if (state is LibraryLoadedState) {
      final currentState = state as LibraryLoadedState;
      
      // Filter items based on selected filter
      final filteredItems = _filterItems(currentState.allItems, event.filter);
      
      emit(LibraryLoadedState(
        allItems: currentState.allItems,
        filteredItems: filteredItems,
        selectedFilter: event.filter,
        viewType: currentState.viewType,
        sortType: currentState.sortType,
        likedSongs: currentState.likedSongs,
      ));
    }
  }

  void _onViewTypeChanged(LibraryViewTypeChangedEvent event, Emitter<LibraryState> emit) {
    if (state is LibraryLoadedState) {
      final currentState = state as LibraryLoadedState;
      
      emit(LibraryLoadedState(
        allItems: currentState.allItems,
        filteredItems: currentState.filteredItems,
        selectedFilter: currentState.selectedFilter,
        viewType: event.viewType,
        sortType: currentState.sortType,
        likedSongs: currentState.likedSongs,
      ));
    }
  }

  void _onSortTypeChanged(LibrarySortTypeChangedEvent event, Emitter<LibraryState> emit) {
    if (state is LibraryLoadedState) {
      final currentState = state as LibraryLoadedState;
      
      // Sort filtered items
      final sortedItems = _sortItems(currentState.filteredItems, event.sortType);
      
      emit(LibraryLoadedState(
        allItems: currentState.allItems,
        filteredItems: sortedItems,
        selectedFilter: currentState.selectedFilter,
        viewType: currentState.viewType,
        sortType: event.sortType,
        likedSongs: currentState.likedSongs,
      ));
    }
  }

  List<dynamic> _filterItems(List<dynamic> items, LibraryFilter filter) {
    switch (filter) {
      case LibraryFilter.all:
        return items;
      case LibraryFilter.playlists:
        return items.where((item) => item is Playlist).toList();
      case LibraryFilter.artists:
        return items.where((item) => item is Artist).toList();
      case LibraryFilter.albums:
        return items.where((item) => item is Album).toList();
      case LibraryFilter.downloaded:
        return []; // Implement downloaded filter
    }
  }

  List<dynamic> _sortItems(List<dynamic> items, LibrarySortType sortType) {
    final sortedItems = List<dynamic>.from(items);
    
    switch (sortType) {
      case LibrarySortType.recentlyAdded:
        // Sort by recently added (mock implementation)
        break;
      case LibrarySortType.alphabetical:
        sortedItems.sort((a, b) {
          String nameA = '';
          String nameB = '';
          
          if (a is Playlist) nameA = a.name;
          if (a is Artist) nameA = a.name;
          if (a is Album) nameA = a.name;
          
          if (b is Playlist) nameB = b.name;
          if (b is Artist) nameB = b.name;
          if (b is Album) nameB = b.name;
          
          return nameA.compareTo(nameB);
        });
        break;
      case LibrarySortType.creator:
        // Sort by creator (mock implementation)
        break;
    }
    
    return sortedItems;
  }
}

