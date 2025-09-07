part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

class PlayerPlayEvent extends PlayerEvent {}

class PlayerPauseEvent extends PlayerEvent {}

class PlayerStopEvent extends PlayerEvent {}

class PlayerNextEvent extends PlayerEvent {}

class PlayerPreviousEvent extends PlayerEvent {}

class PlayerSeekEvent extends PlayerEvent {
  final Duration position;

  const PlayerSeekEvent(this.position);

  @override
  List<Object> get props => [position];
}

class PlayerShuffleToggleEvent extends PlayerEvent {}

class PlayerRepeatToggleEvent extends PlayerEvent {}

class PlayerLoadTrackEvent extends PlayerEvent {
  final Track track;
  final Playlist? playlist;
  final List<Track>? queue;
  final int? startIndex;

  const PlayerLoadTrackEvent({
    required this.track,
    this.playlist,
    this.queue,
    this.startIndex,
  });

  @override
  List<Object?> get props => [track, playlist, queue, startIndex];
}

class PlayerLoadPlaylistEvent extends PlayerEvent {
  final Playlist playlist;
  final int startIndex;

  const PlayerLoadPlaylistEvent({
    required this.playlist,
    this.startIndex = 0,
  });

  @override
  List<Object> get props => [playlist, startIndex];
}

class PlayerToggleLikeEvent extends PlayerEvent {
  final Track track;

  const PlayerToggleLikeEvent(this.track);

  @override
  List<Object> get props => [track];
}

class PlayerPositionChangedEvent extends PlayerEvent {
  final Duration position;

  const PlayerPositionChangedEvent(this.position);

  @override
  List<Object> get props => [position];
}

class PlayerVolumeChangedEvent extends PlayerEvent {
  final double volume;

  const PlayerVolumeChangedEvent(this.volume);

  @override
  List<Object> get props => [volume];
}
