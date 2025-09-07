import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import '../../../domain/models/track.dart';
import '../../../domain/models/playlist.dart';
import '../../../data/services/audio_player_service.dart';

part 'player_event.dart';
part 'player_state.dart';

@injectable
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final AudioPlayerService _audioService;
  late StreamSubscription _playerStateSubscription;
  late StreamSubscription _positionSubscription;

  PlayerBloc(this._audioService) : super(PlayerInitialState()) {
    on<PlayerPlayEvent>(_onPlay);
    on<PlayerPauseEvent>(_onPause);
    on<PlayerStopEvent>(_onStop);
    on<PlayerNextEvent>(_onNext);
    on<PlayerPreviousEvent>(_onPrevious);
    on<PlayerSeekEvent>(_onSeek);
    on<PlayerShuffleToggleEvent>(_onShuffleToggle);
    on<PlayerRepeatToggleEvent>(_onRepeatToggle);
    on<PlayerLoadTrackEvent>(_onLoadTrack);
    on<PlayerLoadPlaylistEvent>(_onLoadPlaylist);
    on<PlayerToggleLikeEvent>(_onToggleLike);
    on<PlayerPositionChangedEvent>(_onPositionChanged);
    
    _initializeAudioService();
  }

  void _initializeAudioService() {
    // Listen to audio player state changes
    _playerStateSubscription = _audioService.playerStateStream.listen((playerState) {
      if (playerState.playing) {
        add(PlayerPositionChangedEvent(_audioService.player.position));
      }
    });

    // Listen to position changes
    _positionSubscription = _audioService.positionStream.listen((position) {
      add(PlayerPositionChangedEvent(position));
    });
  }

  @override
  Future<void> close() {
    _playerStateSubscription.cancel();
    _positionSubscription.cancel();
    return super.close();
  }

  void _onPlay(PlayerPlayEvent event, Emitter<PlayerState> emit) async {
    try {
      await _audioService.play();
      
      if (state is PlayerPausedState) {
        final pausedState = state as PlayerPausedState;
        emit(PlayerPlayingState(
          currentTrack: pausedState.currentTrack,
          currentPlaylist: pausedState.currentPlaylist,
          queue: pausedState.queue,
          currentIndex: pausedState.currentIndex,
          position: pausedState.position,
          duration: pausedState.duration,
          isShuffled: pausedState.isShuffled,
          repeatMode: pausedState.repeatMode,
        ));
      }
    } catch (e) {
      print('Error playing: $e');
    }
  }

  void _onPause(PlayerPauseEvent event, Emitter<PlayerState> emit) async {
    try {
      await _audioService.pause();
      
      if (state is PlayerPlayingState) {
        final playingState = state as PlayerPlayingState;
        emit(PlayerPausedState(
          currentTrack: playingState.currentTrack,
          currentPlaylist: playingState.currentPlaylist,
          queue: playingState.queue,
          currentIndex: playingState.currentIndex,
          position: playingState.position,
          duration: playingState.duration,
          isShuffled: playingState.isShuffled,
          repeatMode: playingState.repeatMode,
        ));
      }
    } catch (e) {
      print('Error pausing: $e');
    }
  }

  void _onStop(PlayerStopEvent event, Emitter<PlayerState> emit) {
    emit(PlayerInitialState());
  }

  void _onNext(PlayerNextEvent event, Emitter<PlayerState> emit) {
    if (state is PlayerPlayingState || state is PlayerPausedState) {
      final currentState = state as dynamic;
      final queue = currentState.queue as List<Track>;
      final currentIndex = currentState.currentIndex as int;
      
      if (currentIndex < queue.length - 1) {
        final nextIndex = currentIndex + 1;
        final nextTrack = queue[nextIndex];
        
        if (state is PlayerPlayingState) {
          emit(PlayerPlayingState(
            currentTrack: nextTrack,
            currentPlaylist: currentState.currentPlaylist,
            queue: queue,
            currentIndex: nextIndex,
            position: Duration.zero,
            duration: Duration(milliseconds: nextTrack.durationMs),
            isShuffled: currentState.isShuffled,
            repeatMode: currentState.repeatMode,
          ));
        } else {
          emit(PlayerPausedState(
            currentTrack: nextTrack,
            currentPlaylist: currentState.currentPlaylist,
            queue: queue,
            currentIndex: nextIndex,
            position: Duration.zero,
            duration: Duration(milliseconds: nextTrack.durationMs),
            isShuffled: currentState.isShuffled,
            repeatMode: currentState.repeatMode,
          ));
        }
      }
    }
  }

  void _onPrevious(PlayerPreviousEvent event, Emitter<PlayerState> emit) {
    if (state is PlayerPlayingState || state is PlayerPausedState) {
      final currentState = state as dynamic;
      final queue = currentState.queue as List<Track>;
      final currentIndex = currentState.currentIndex as int;
      
      if (currentIndex > 0) {
        final previousIndex = currentIndex - 1;
        final previousTrack = queue[previousIndex];
        
        if (state is PlayerPlayingState) {
          emit(PlayerPlayingState(
            currentTrack: previousTrack,
            currentPlaylist: currentState.currentPlaylist,
            queue: queue,
            currentIndex: previousIndex,
            position: Duration.zero,
            duration: Duration(milliseconds: previousTrack.durationMs),
            isShuffled: currentState.isShuffled,
            repeatMode: currentState.repeatMode,
          ));
        } else {
          emit(PlayerPausedState(
            currentTrack: previousTrack,
            currentPlaylist: currentState.currentPlaylist,
            queue: queue,
            currentIndex: previousIndex,
            position: Duration.zero,
            duration: Duration(milliseconds: previousTrack.durationMs),
            isShuffled: currentState.isShuffled,
            repeatMode: currentState.repeatMode,
          ));
        }
      }
    }
  }

  void _onSeek(PlayerSeekEvent event, Emitter<PlayerState> emit) {
    if (state is PlayerPlayingState) {
      final playingState = state as PlayerPlayingState;
      emit(PlayerPlayingState(
        currentTrack: playingState.currentTrack,
        currentPlaylist: playingState.currentPlaylist,
        queue: playingState.queue,
        currentIndex: playingState.currentIndex,
        position: event.position,
        duration: playingState.duration,
        isShuffled: playingState.isShuffled,
        repeatMode: playingState.repeatMode,
      ));
    } else if (state is PlayerPausedState) {
      final pausedState = state as PlayerPausedState;
      emit(PlayerPausedState(
        currentTrack: pausedState.currentTrack,
        currentPlaylist: pausedState.currentPlaylist,
        queue: pausedState.queue,
        currentIndex: pausedState.currentIndex,
        position: event.position,
        duration: pausedState.duration,
        isShuffled: pausedState.isShuffled,
        repeatMode: pausedState.repeatMode,
      ));
    }
  }

  void _onShuffleToggle(PlayerShuffleToggleEvent event, Emitter<PlayerState> emit) {
    if (state is PlayerPlayingState) {
      final playingState = state as PlayerPlayingState;
      emit(PlayerPlayingState(
        currentTrack: playingState.currentTrack,
        currentPlaylist: playingState.currentPlaylist,
        queue: playingState.queue,
        currentIndex: playingState.currentIndex,
        position: playingState.position,
        duration: playingState.duration,
        isShuffled: !playingState.isShuffled,
        repeatMode: playingState.repeatMode,
      ));
    } else if (state is PlayerPausedState) {
      final pausedState = state as PlayerPausedState;
      emit(PlayerPausedState(
        currentTrack: pausedState.currentTrack,
        currentPlaylist: pausedState.currentPlaylist,
        queue: pausedState.queue,
        currentIndex: pausedState.currentIndex,
        position: pausedState.position,
        duration: pausedState.duration,
        isShuffled: !pausedState.isShuffled,
        repeatMode: pausedState.repeatMode,
      ));
    }
  }

  void _onRepeatToggle(PlayerRepeatToggleEvent event, Emitter<PlayerState> emit) {
    if (state is PlayerPlayingState) {
      final playingState = state as PlayerPlayingState;
      final newRepeatMode = _getNextRepeatMode(playingState.repeatMode);
      emit(PlayerPlayingState(
        currentTrack: playingState.currentTrack,
        currentPlaylist: playingState.currentPlaylist,
        queue: playingState.queue,
        currentIndex: playingState.currentIndex,
        position: playingState.position,
        duration: playingState.duration,
        isShuffled: playingState.isShuffled,
        repeatMode: newRepeatMode,
      ));
    } else if (state is PlayerPausedState) {
      final pausedState = state as PlayerPausedState;
      final newRepeatMode = _getNextRepeatMode(pausedState.repeatMode);
      emit(PlayerPausedState(
        currentTrack: pausedState.currentTrack,
        currentPlaylist: pausedState.currentPlaylist,
        queue: pausedState.queue,
        currentIndex: pausedState.currentIndex,
        position: pausedState.position,
        duration: pausedState.duration,
        isShuffled: pausedState.isShuffled,
        repeatMode: newRepeatMode,
      ));
    }
  }

  void _onLoadTrack(PlayerLoadTrackEvent event, Emitter<PlayerState> emit) async {
    try {
      emit(PlayerLoadingState());
      
      await _audioService.playTrack(
        event.track,
        playlistTracks: event.queue ?? [event.track],
        startIndex: event.startIndex ?? 0,
      );
      
      emit(PlayerPlayingState(
        currentTrack: event.track,
        currentPlaylist: event.playlist,
        queue: event.queue ?? [event.track],
        currentIndex: event.startIndex ?? 0,
        position: Duration.zero,
        duration: Duration(milliseconds: event.track.durationMs),
        isShuffled: false,
        repeatMode: RepeatMode.off,
      ));
    } catch (e) {
      print('Error loading track: $e');
      emit(PlayerErrorState('Failed to play track: ${e.toString()}'));
    }
  }

  void _onLoadPlaylist(PlayerLoadPlaylistEvent event, Emitter<PlayerState> emit) {
    if (event.playlist.tracks != null && event.playlist.tracks!.isNotEmpty) {
      final track = event.playlist.tracks![event.startIndex];
      emit(PlayerPlayingState(
        currentTrack: track,
        currentPlaylist: event.playlist,
        queue: event.playlist.tracks!,
        currentIndex: event.startIndex,
        position: Duration.zero,
        duration: Duration(milliseconds: track.durationMs),
        isShuffled: false,
        repeatMode: RepeatMode.off,
      ));
    }
  }

  void _onToggleLike(PlayerToggleLikeEvent event, Emitter<PlayerState> emit) {
    // Toggle the like status of the track
    if (state is PlayerPlayingState) {
      final playingState = state as PlayerPlayingState;
      if (playingState.currentTrack?.id == event.track.id) {
        // Update the current track's like status
        final updatedTrack = Track(
          id: event.track.id,
          name: event.track.name,
          artists: event.track.artists,
          album: event.track.album,
          durationMs: event.track.durationMs,
          explicit: event.track.explicit,
          popularity: event.track.popularity,
          isLocal: event.track.isLocal,
          isPlayable: event.track.isPlayable,
          previewUrl: event.track.previewUrl,
          isLiked: !event.track.isLiked, // Toggle like status
          trackNumber: event.track.trackNumber,
        );
        
        emit(PlayerPlayingState(
          currentTrack: updatedTrack,
          currentPlaylist: playingState.currentPlaylist,
          queue: playingState.queue,
          currentIndex: playingState.currentIndex,
          position: playingState.position,
          duration: playingState.duration,
          isShuffled: playingState.isShuffled,
          repeatMode: playingState.repeatMode,
        ));
      }
    } else if (state is PlayerPausedState) {
      final pausedState = state as PlayerPausedState;
      if (pausedState.currentTrack?.id == event.track.id) {
        // Update the current track's like status
        final updatedTrack = Track(
          id: event.track.id,
          name: event.track.name,
          artists: event.track.artists,
          album: event.track.album,
          durationMs: event.track.durationMs,
          explicit: event.track.explicit,
          popularity: event.track.popularity,
          isLocal: event.track.isLocal,
          isPlayable: event.track.isPlayable,
          previewUrl: event.track.previewUrl,
          isLiked: !event.track.isLiked, // Toggle like status
          trackNumber: event.track.trackNumber,
        );
        
        emit(PlayerPausedState(
          currentTrack: updatedTrack,
          currentPlaylist: pausedState.currentPlaylist,
          queue: pausedState.queue,
          currentIndex: pausedState.currentIndex,
          position: pausedState.position,
          duration: pausedState.duration,
          isShuffled: pausedState.isShuffled,
          repeatMode: pausedState.repeatMode,
        ));
      }
    }
  }

  void _onPositionChanged(PlayerPositionChangedEvent event, Emitter<PlayerState> emit) {
    if (state is PlayerPlayingState) {
      final playingState = state as PlayerPlayingState;
      emit(PlayerPlayingState(
        currentTrack: playingState.currentTrack,
        currentPlaylist: playingState.currentPlaylist,
        queue: playingState.queue,
        currentIndex: playingState.currentIndex,
        position: event.position,
        duration: playingState.duration,
        isShuffled: playingState.isShuffled,
        repeatMode: playingState.repeatMode,
      ));
    }
  }

  RepeatMode _getNextRepeatMode(RepeatMode currentMode) {
    switch (currentMode) {
      case RepeatMode.off:
        return RepeatMode.all;
      case RepeatMode.all:
        return RepeatMode.one;
      case RepeatMode.one:
        return RepeatMode.off;
    }
  }
}
