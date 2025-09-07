import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/user.dart';
import '../../../domain/models/track.dart';
import '../../../domain/models/playlist.dart';
import '../../../domain/models/artist.dart';
import '../../../domain/models/album.dart';
import '../../../data/services/discogs_api_service.dart';
import '../../../data/services/mock_data_service.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DiscogsApiService _discogsApiService;
  final MockDataService _mockDataService = MockDataService.instance;

  HomeBloc(this._discogsApiService) : super(HomeInitialState()) {
    on<HomeLoadDataEvent>(_onLoadData);
    on<HomeRefreshEvent>(_onRefresh);
  }

  void _onLoadData(HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    
    try {
      // Use comprehensive mock data service
      final recentlyPlayed = _mockDataService.getRecentlyPlayedTracks();
      final featuredPlaylists = _mockDataService.getFeaturedPlaylists();
      final allPlaylists = _mockDataService.playlists;
      final currentUser = _mockDataService.currentUser;
      
      emit(HomeLoadedState(
        user: currentUser,
        recentlyPlayed: recentlyPlayed,
        recentPlaylists: featuredPlaylists,
        madeForYouPlaylists: allPlaylists.take(3).toList(),
        recommendedPlaylists: allPlaylists.skip(2).take(3).toList(),
        jumpBackInItems: featuredPlaylists,
      ));
    } catch (e) {
      print('Error loading home data: $e');
      emit(HomeErrorState('Failed to load home data. Please try again.'));
    }
  }


  void _onRefresh(HomeRefreshEvent event, Emitter<HomeState> emit) async {
    // Refresh data without showing loading state
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      // Reload fresh data
      final recentlyPlayed = _mockDataService.getRecentlyPlayedTracks();
      final featuredPlaylists = _mockDataService.getFeaturedPlaylists();
      final allPlaylists = _mockDataService.playlists;
      final currentUser = _mockDataService.currentUser;
      
      emit(HomeLoadedState(
        user: currentUser,
        recentlyPlayed: recentlyPlayed,
        recentPlaylists: featuredPlaylists,
        madeForYouPlaylists: allPlaylists.take(3).toList(),
        recommendedPlaylists: allPlaylists.skip(2).take(3).toList(),
        jumpBackInItems: featuredPlaylists,
      ));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}
