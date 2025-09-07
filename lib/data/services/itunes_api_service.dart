import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/track.dart';
import '../../domain/models/artist.dart';
import '../../domain/models/album.dart';

@injectable
class ItunesApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://itunes.apple.com';
  
  ItunesApiService() : _dio = Dio() {
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
      print('Searching iTunes for: $term');
      
      final response = await _dio.get(
        '/search',
        queryParameters: {
          'term': term,
          'media': 'music',
          'entity': 'song',
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print('iTunes API returned ${data['resultCount']} results for: $term');
        
        if (data is Map<String, dynamic> && data['results'] is List) {
          final results = data['results'] as List<dynamic>;
          
          for (final item in results.take(limit)) {
            if (item is Map<String, dynamic>) {
              try {
                final track = _mapSongToTrack(item);
                allTracks.add(track);
              } catch (e) {
                print('Failed to map iTunes track: $e');
                // Continue with other tracks
              }
            }
          }
        }
      }
    } catch (e) {
      print('Error searching iTunes: $e');
    }
    
    print('Total tracks found from iTunes: ${allTracks.length}');
    return allTracks;
  }

  Future<List<Track>> getPopularTracks() async {
    // Get popular tracks by searching for trending terms
    final List<String> popularTerms = [
      'top hits 2024',
      'billboard hot 100',
      'trending music',
      'popular songs',
      'chart toppers',
    ];

    final List<Track> allTracks = [];
    
    for (String term in popularTerms.take(3)) {
      try {
        final tracks = await searchTracks(term, limit: 5);
        allTracks.addAll(tracks);
      } catch (e) {
        print('Error fetching tracks for $term: $e');
      }
    }

    return allTracks;
  }

  Track _mapSongToTrack(Map<String, dynamic> json) {
    try {
      final id = json['trackId']?.toString() ?? '0';
      final trackName = json['trackName'] ?? 'Unknown Track';
      final artistName = json['artistName'] ?? 'Unknown Artist';
      
      print('Mapping iTunes track: $trackName by $artistName');
      
      return Track(
        id: id,
        name: trackName,
        artists: [_mapToArtist(json)],
        album: _mapToAlbum(json),
        durationMs: json['trackTimeMillis'] ?? _estimateDuration(),
        explicit: json['trackExplicitness'] == 'explicit',
        popularity: _calculatePopularity(json),
        isLocal: false,
        isPlayable: true,
        previewUrl: json['previewUrl'] ?? 'https://www.soundjay.com/misc/sounds/bell-ringing-05.wav',
        isLiked: false,
        trackNumber: json['trackNumber'] ?? 1,
      );
    } catch (e) {
      print('Error mapping iTunes track: $e');
      print('JSON: $json');
      rethrow;
    }
  }

  Artist _mapToArtist(Map<String, dynamic> json) {
    return Artist(
      id: json['artistId']?.toString() ?? '0',
      name: json['artistName'] ?? 'Unknown Artist',
      genres: _extractGenres(json),
      popularity: _calculatePopularity(json),
      followers: 1000000, // Default value
      images: [_getArtworkUrl(json, size: 600)],
      isFollowing: false,
    );
  }

  Album _mapToAlbum(Map<String, dynamic> json) {
    return Album(
      id: json['collectionId']?.toString() ?? '0',
      name: json['collectionName'] ?? 'Unknown Album',
      artists: [_mapToArtist(json)],
      albumType: _getAlbumType(json),
      totalTracks: json['trackCount'] ?? 1,
      images: [
        _getArtworkUrl(json, size: 600),
        _getArtworkUrl(json, size: 300),
        _getArtworkUrl(json, size: 100),
      ],
      releaseDate: _parseReleaseDate(json['releaseDate']),
      releaseDatePrecision: 'day',
      genres: _extractGenres(json),
      popularity: _calculatePopularity(json),
      isSaved: false,
    );
  }

  List<String> _extractGenres(Map<String, dynamic> json) {
    final genres = <String>[];
    
    if (json['primaryGenreName'] != null) {
      genres.add(json['primaryGenreName']);
    }
    
    return genres.isNotEmpty ? genres : ['Music'];
  }

  String _getArtworkUrl(Map<String, dynamic> json, {int size = 300}) {
    final artworkUrl = json['artworkUrl100'] ?? json['artworkUrl60'] ?? json['artworkUrl30'];
    
    if (artworkUrl != null) {
      // Replace the size in the URL
      return artworkUrl.toString().replaceAll('100x100', '${size}x$size');
    }
    
    // Fallback to placeholder
    return 'https://picsum.photos/$size/$size?random=${json['trackId'] ?? 0}';
  }

  String _getAlbumType(Map<String, dynamic> json) {
    final collectionType = json['collectionType']?.toString().toLowerCase() ?? '';
    
    if (collectionType.contains('single')) return 'single';
    if (collectionType.contains('compilation')) return 'compilation';
    
    return 'album';
  }

  int _calculatePopularity(Map<String, dynamic> json) {
    // Use track price and collection price as popularity indicators
    final trackPrice = json['trackPrice'] ?? 0.0;
    final collectionPrice = json['collectionPrice'] ?? 0.0;
    
    // Higher priced tracks might be more popular/premium
    if (trackPrice > 1.5 || collectionPrice > 15.0) return 90;
    if (trackPrice > 1.0 || collectionPrice > 10.0) return 85;
    if (trackPrice > 0.5 || collectionPrice > 5.0) return 80;
    
    return 75; // Default popularity
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
