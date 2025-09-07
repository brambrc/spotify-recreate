part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final User? user;
  final List<Track> recentlyPlayed;
  final List<Playlist> recentPlaylists;
  final List<Playlist> madeForYouPlaylists;
  final List<Playlist> recommendedPlaylists;
  final List<Playlist> jumpBackInItems;

  const HomeLoadedState({
    this.user,
    required this.recentlyPlayed,
    required this.recentPlaylists,
    required this.madeForYouPlaylists,
    required this.recommendedPlaylists,
    required this.jumpBackInItems,
  });

  @override
  List<Object?> get props => [
        user,
        recentlyPlayed,
        recentPlaylists,
        madeForYouPlaylists,
        recommendedPlaylists,
        jumpBackInItems,
      ];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message);

  @override
  List<Object> get props => [message];
}

