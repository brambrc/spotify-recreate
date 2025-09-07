part of 'player_bloc.dart';

enum RepeatMode { off, all, one }

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object?> get props => [];
}

class PlayerInitialState extends PlayerState {}

class PlayerLoadingState extends PlayerState {}

class PlayerPlayingState extends PlayerState {
  final Track? currentTrack;
  final Playlist? currentPlaylist;
  final List<Track> queue;
  final int currentIndex;
  final Duration position;
  final Duration duration;
  final bool isShuffled;
  final RepeatMode repeatMode;
  final double volume;

  const PlayerPlayingState({
    this.currentTrack,
    this.currentPlaylist,
    required this.queue,
    required this.currentIndex,
    required this.position,
    required this.duration,
    required this.isShuffled,
    required this.repeatMode,
    this.volume = 1.0,
  });

  @override
  List<Object?> get props => [
        currentTrack,
        currentPlaylist,
        queue,
        currentIndex,
        position,
        duration,
        isShuffled,
        repeatMode,
        volume,
      ];
}

class PlayerPausedState extends PlayerState {
  final Track? currentTrack;
  final Playlist? currentPlaylist;
  final List<Track> queue;
  final int currentIndex;
  final Duration position;
  final Duration duration;
  final bool isShuffled;
  final RepeatMode repeatMode;
  final double volume;

  const PlayerPausedState({
    this.currentTrack,
    this.currentPlaylist,
    required this.queue,
    required this.currentIndex,
    required this.position,
    required this.duration,
    required this.isShuffled,
    required this.repeatMode,
    this.volume = 1.0,
  });

  @override
  List<Object?> get props => [
        currentTrack,
        currentPlaylist,
        queue,
        currentIndex,
        position,
        duration,
        isShuffled,
        repeatMode,
        volume,
      ];
}

class PlayerStoppedState extends PlayerState {}

class PlayerErrorState extends PlayerState {
  final String message;

  const PlayerErrorState(this.message);

  @override
  List<Object> get props => [message];
}

