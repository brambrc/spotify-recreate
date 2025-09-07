import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/track.dart';
import '../../domain/models/artist.dart';
import '../../domain/models/album.dart';

@injectable
class JamendoApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.jamendo.com/v3.0';
  static const String _clientId = 'a40f8777'; // Public client ID for demo
  
  JamendoApiService() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.headers = {
      'Accept': 'application/json',
    };
  }

  Future<List<Track>> searchTracks(String term, {int limit = 20}) async {
    final allTracks = <Track>[];
    
    try {
      print('Searching Jamendo for: $term');
      
      final response = await _dio.get(
        '/tracks',
        queryParameters: {
          'client_id': _clientId,
          'format': 'json',
          'search': term,
          'limit': limit,
          'include': 'musicinfo',
          'audioformat': 'mp32',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print('Jamendo API returned data for: $term');
        
        if (data is Map<String, dynamic> && data['results'] is List) {
          final results = data['results'] as List<dynamic>;
          print('Found ${results.length} tracks from Jamendo');
          
          for (final item in results.take(limit)) {
            if (item is Map<String, dynamic>) {
              try {
                final track = _mapTrackToTrack(item);
                allTracks.add(track);
              } catch (e) {
                print('Failed to map Jamendo track: $e');
                // Continue with other tracks
              }
            }
          }
        }
      }
    } catch (e) {
      print('Error searching Jamendo: $e');
    }
    
    print('Total tracks found from Jamendo: ${allTracks.length}');
    return allTracks;
  }

  Future<List<Track>> getPopularTracks() async {
    try {
      print('Fetching popular tracks from Jamendo');
      
      final response = await _dio.get(
        '/tracks',
        queryParameters: {
          'client_id': _clientId,
          'format': 'json',
          'order': 'popularity_total',
          'limit': 20,
          'include': 'musicinfo',
          'audioformat': 'mp32',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        
        if (data is Map<String, dynamic> && data['results'] is List) {
          final results = data['results'] as List<dynamic>;
          print('Found ${results.length} popular tracks from Jamendo');
          
          final tracks = <Track>[];
          for (final item in results) {
            if (item is Map<String, dynamic>) {
              try {
                final track = _mapTrackToTrack(item);
                tracks.add(track);
              } catch (e) {
                print('Failed to map Jamendo popular track: $e');
              }
            }
          }
          return tracks;
        }
      }
    } catch (e) {
      print('Error fetching popular tracks from Jamendo: $e');
    }
    
    return [];
  }

  Track _mapTrackToTrack(Map<String, dynamic> json) {
    try {
      final id = json['id']?.toString() ?? '0';
      final trackName = json['name'] ?? 'Unknown Track';
      final artistName = json['artist_name'] ?? 'Unknown Artist';
      
      print('Mapping Jamendo track: $trackName by $artistName');
      
      return Track(
        id: id,
        name: trackName,
        artists: [_mapToArtist(json)],
        album: _mapToAlbum(json),
        durationMs: (json['duration'] != null) 
            ? (double.parse(json['duration'].toString()) * 1000).round()
            : _estimateDuration(),
        explicit: false, // Jamendo is generally family-friendly
        popularity: _calculatePopularity(json),
        isLocal: false,
        isPlayable: true,
        previewUrl: json['audio'] ?? json['audiodownload'] ?? 'https://www.soundjay.com/misc/sounds/bell-ringing-05.wav',
        isLiked: false,
        trackNumber: json['position'] ?? 1,
      );
    } catch (e) {
      print('Error mapping Jamendo track: $e');
      print('JSON: $json');
      rethrow;
    }
  }

  Artist _mapToArtist(Map<String, dynamic> json) {
    return Artist(
      id: json['artist_id']?.toString() ?? '0',
      name: json['artist_name'] ?? 'Unknown Artist',
      genres: _extractGenres(json),
      popularity: _calculatePopularity(json),
      followers: 50000, // Default value for Jamendo artists
      images: [_getArtistImage(json)],
      isFollowing: false,
    );
  }

  Album _mapToAlbum(Map<String, dynamic> json) {
    return Album(
      id: json['album_id']?.toString() ?? '0',
      name: json['album_name'] ?? 'Unknown Album',
      artists: [_mapToArtist(json)],
      albumType: 'album',
      totalTracks: 1, // Not available in track endpoint
      images: [
        _getAlbumImage(json, size: 600),
        _getAlbumImage(json, size: 300),
        _getAlbumImage(json, size: 150),
      ],
      releaseDate: _parseReleaseDate(json['releasedate']),
      releaseDatePrecision: 'day',
      genres: _extractGenres(json),
      popularity: _calculatePopularity(json),
      isSaved: false,
    );
  }

  List<String> _extractGenres(Map<String, dynamic> json) {
    final genres = <String>[];
    
    // Extract from musicinfo
    if (json['musicinfo'] is Map<String, dynamic>) {
      final musicInfo = json['musicinfo'] as Map<String, dynamic>;
      
      if (musicInfo['tags'] is Map<String, dynamic>) {
        final tags = musicInfo['tags'] as Map<String, dynamic>;
        
        // Add genres and vartags
        if (tags['genres'] is List) {
          for (final genre in tags['genres']) {
            if (genre is String && genre.isNotEmpty) {
              genres.add(genre);
            }
          }
        }
        
        if (tags['vartags'] is List) {
          for (final tag in tags['vartags']) {
            if (tag is String && tag.isNotEmpty) {
              genres.add(tag);
            }
          }
        }
      }
    }
    
    return genres.isNotEmpty ? genres : ['Music'];
  }

  String _getAlbumImage(Map<String, dynamic> json, {int size = 300}) {
    final albumImage = json['album_image'];
    
    if (albumImage != null && albumImage.toString().isNotEmpty) {
      return albumImage.toString();
    }
    
    // Fallback to placeholder
    return 'https://picsum.photos/$size/$size?random=${json['album_id'] ?? 0}';
  }

  String _getArtistImage(Map<String, dynamic> json) {
    // Jamendo doesn't typically provide artist images in track endpoint
    // Use a placeholder based on artist ID
    return 'https://picsum.photos/300/300?random=${json['artist_id'] ?? 0}';
  }

  int _calculatePopularity(Map<String, dynamic> json) {
    // Use downloads and listens as popularity indicators
    final downloads = json['stats']?['downloads'] ?? 0;
    final listens = json['stats']?['listens'] ?? 0;
    
    final totalEngagement = downloads + listens;
    
    if (totalEngagement > 100000) return 95;
    if (totalEngagement > 50000) return 90;
    if (totalEngagement > 10000) return 85;
    if (totalEngagement > 5000) return 80;
    if (totalEngagement > 1000) return 75;
    
    return 70; // Default popularity
  }

  int _estimateDuration() {
    // Generate a random duration between 2:30 and 4:30 minutes
    const minDuration = 150000; // 2:30 in milliseconds
    const maxDuration = 270000; // 4:30 in milliseconds
    
    return minDuration + (DateTime.now().millisecondsSinceEpoch % (maxDuration - minDuration));
  }

  DateTime _parseReleaseDate(dynamic releaseDate) {
    if (releaseDate == null) return DateTime.now();
    try {
      return DateTime.parse(releaseDate.toString());
    } catch (e) {
      return DateTime.now();
    }
  }
}
