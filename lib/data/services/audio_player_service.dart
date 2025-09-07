import 'package:just_audio/just_audio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/track.dart';

@lazySingleton
class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  Track? _currentTrack;
  List<Track> _playlist = [];
  int _currentIndex = 0;
  
  // Getters
  AudioPlayer get player => _audioPlayer;
  Track? get currentTrack => _currentTrack;
  List<Track> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  
  // Stream getters
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<bool> get playingStream => _audioPlayer.playingStream;
  
  bool get isPlaying => _audioPlayer.playing;
  bool get hasNext => _currentIndex < _playlist.length - 1;
  bool get hasPrevious => _currentIndex > 0;
  
  Future<void> initialize() async {
    // Initialize audio player
    await _audioPlayer.setLoopMode(LoopMode.off);
    await _audioPlayer.setShuffleModeEnabled(false);
  }

  Future<void> playTrack(Track track, {List<Track>? playlistTracks, int? startIndex}) async {
    try {
      if (playlistTracks != null) {
        _playlist = playlistTracks;
        _currentIndex = startIndex ?? 0;
        _currentTrack = _playlist[_currentIndex];
      } else {
        _currentTrack = track;
        _playlist = [track];
        _currentIndex = 0;
      }
      
      // Check if track has preview URL
      if (_currentTrack?.previewUrl != null) {
        print('Playing: ${_currentTrack?.name} - ${_currentTrack?.previewUrl}');
        await _audioPlayer.setUrl(_currentTrack!.previewUrl!);
        await _audioPlayer.play();
      } else {
        print('No preview URL available for: ${_currentTrack?.name}');
        // Play a demo/placeholder audio or show error
        throw Exception('No preview available for this track');
      }
    } catch (e) {
      print('Error playing track: $e');
      rethrow;
    }
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> skipToNext() async {
    if (hasNext) {
      _currentIndex++;
      _currentTrack = _playlist[_currentIndex];
      await playTrack(_currentTrack!);
    }
  }

  Future<void> skipToPrevious() async {
    if (hasPrevious) {
      _currentIndex--;
      _currentTrack = _playlist[_currentIndex];
      await playTrack(_currentTrack!);
    }
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  Future<void> setShuffleMode(bool enabled) async {
    await _audioPlayer.setShuffleModeEnabled(enabled);
  }

  Future<void> setRepeatMode(LoopMode mode) async {
    await _audioPlayer.setLoopMode(mode);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

