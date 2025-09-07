import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/track.dart';
import '../../domain/models/artist.dart';
import '../../domain/models/album.dart';

@injectable
class DiscogsApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.discogs.com';
  static const String _userAgent = 'SpotifyEnhancement/1.0.0';
  
  DiscogsApiService() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.headers = {
      'User-Agent': _userAgent,
      'Accept': 'application/json',
    };
  }

  Future<List<Track>> searchTracks(String term, {int limit = 20}) async {
    final allTracks = <Track>[];
    
    try {
      print('Searching Discogs for: $term');
      
      // Search for releases (albums/singles)
      final releaseResponse = await _dio.get(
        '/database/search',
        queryParameters: {
          'q': term,
          'type': 'release',
          'per_page': limit,
          'format': 'vinyl,cd,digital',
        },
      );

      if (releaseResponse.statusCode == 200) {
        final data = releaseResponse.data;
        print('Discogs API returned ${data['pagination']['items']} results for: $term');
        
        if (data is Map<String, dynamic> && data['results'] is List) {
          final results = data['results'] as List<dynamic>;
          
          for (final item in results.take(limit)) {
            if (item is Map<String, dynamic>) {
              try {
                final track = _mapReleaseToTrack(item);
                allTracks.add(track);
              } catch (e) {
                print('Failed to map Discogs release: $e');
                // Continue with other tracks
              }
            }
          }
        }
      }
    } catch (e) {
      print('Error searching Discogs: $e');
    }
    
    print('Total tracks found from Discogs: ${allTracks.length}');
    return allTracks;
  }

  Future<List<Track>> getPopularTracks() async {
    // Get popular/trending tracks by searching for popular artists
    final List<String> popularArtists = [
      'Taylor Swift',
      'Bad Bunny', 
      'The Weeknd',
      'Drake',
      'Ariana Grande',
      'Post Malone',
      'Billie Eilish',
      'Dua Lipa',
      'Ed Sheeran',
      'Harry Styles',
    ];

    final List<Track> allTracks = [];
    
    for (String artist in popularArtists.take(5)) {
      try {
        final tracks = await searchTracks(artist, limit: 3);
        allTracks.addAll(tracks);
      } catch (e) {
        print('Error fetching tracks for $artist: $e');
      }
    }

    return allTracks;
  }

  Track _mapReleaseToTrack(Map<String, dynamic> json) {
    try {
      final id = json['id']?.toString() ?? '0';
      final title = json['title'] ?? 'Unknown Track';
      final year = json['year']?.toString() ?? '';
      
      // Parse title to extract track name and artist
      final titleParts = title.split(' - ');
      final trackName = titleParts.length > 1 ? titleParts[1] : title;
      final artistName = titleParts.length > 1 ? titleParts[0] : (json['artist'] ?? 'Unknown Artist');
      
      print('Mapping Discogs release: $trackName by $artistName');
      
      return Track(
        id: id,
        name: trackName,
        artists: [_mapToArtist(json, artistName)],
        album: _mapToAlbum(json, artistName),
        durationMs: _estimateDuration(), // Discogs doesn't provide duration, estimate
        explicit: false, // Not available in Discogs
        popularity: _calculatePopularity(json),
        isLocal: false,
        isPlayable: true,
        previewUrl: 'https://www.soundjay.com/misc/sounds/bell-ringing-05.wav', // Demo URL
        isLiked: false,
        trackNumber: 1,
      );
    } catch (e) {
      print('Error mapping Discogs release: $e');
      print('JSON: $json');
      rethrow;
    }
  }

  Artist _mapToArtist(Map<String, dynamic> json, String artistName) {
    return Artist(
      id: json['id']?.toString() ?? '0',
      name: artistName,
      genres: _extractGenres(json),
      popularity: _calculatePopularity(json),
      followers: 1000000, // Default value
      images: [_getArtworkUrl(json)],
      isFollowing: false,
    );
  }

  Album _mapToAlbum(Map<String, dynamic> json, String artistName) {
    final title = json['title'] ?? 'Unknown Album';
    final albumName = title.contains(' - ') ? title.split(' - ')[0] : title;
    
    return Album(
      id: json['id']?.toString() ?? '0',
      name: albumName,
      artists: [_mapToArtist(json, artistName)],
      albumType: _getAlbumType(json),
      totalTracks: 1, // Not available in search results
      images: [
        _getArtworkUrl(json, size: 600),
        _getArtworkUrl(json, size: 300),
        _getArtworkUrl(json, size: 150),
      ],
      releaseDate: _parseReleaseDate(json['year']),
      releaseDatePrecision: 'year',
      genres: _extractGenres(json),
      popularity: _calculatePopularity(json),
      isSaved: false,
    );
  }

  List<String> _extractGenres(Map<String, dynamic> json) {
    final genres = <String>[];
    
    // Extract from style
    if (json['style'] is List) {
      genres.addAll((json['style'] as List).cast<String>());
    }
    
    // Extract from genre
    if (json['genre'] is List) {
      genres.addAll((json['genre'] as List).cast<String>());
    }
    
    return genres.isNotEmpty ? genres : ['Music'];
  }

  String _getArtworkUrl(Map<String, dynamic> json, {int size = 300}) {
    // Try to get cover image from Discogs
    if (json['cover_image'] != null && json['cover_image'] != '') {
      return json['cover_image'];
    }
    
    // Try to get thumb image
    if (json['thumb'] != null && json['thumb'] != '') {
      return json['thumb'];
    }
    
    // Fallback to placeholder
    return 'https://picsum.photos/$size/$size?random=${json['id'] ?? 0}';
  }

  String _getAlbumType(Map<String, dynamic> json) {
    final format = json['format']?.toString().toLowerCase() ?? '';
    
    if (format.contains('single')) return 'single';
    if (format.contains('ep')) return 'album';
    if (format.contains('compilation')) return 'compilation';
    
    return 'album';
  }

  int _calculatePopularity(Map<String, dynamic> json) {
    // Use community ratings/wants as popularity indicator
    final communityHave = json['community']?['have'] ?? 0;
    final communityWant = json['community']?['want'] ?? 0;
    
    // Calculate a popularity score based on community engagement
    final totalEngagement = communityHave + communityWant;
    
    if (totalEngagement > 10000) return 95;
    if (totalEngagement > 5000) return 90;
    if (totalEngagement > 1000) return 85;
    if (totalEngagement > 500) return 80;
    if (totalEngagement > 100) return 75;
    
    return 70; // Default popularity
  }

  int _estimateDuration() {
    // Generate a random duration between 2:30 and 4:30 minutes
    const minDuration = 150000; // 2:30 in milliseconds
    const maxDuration = 270000; // 4:30 in milliseconds
    
    return minDuration + (DateTime.now().millisecondsSinceEpoch % (maxDuration - minDuration));
  }

  DateTime _parseReleaseDate(dynamic year) {
    if (year == null) return DateTime.now();
    try {
      final yearInt = int.parse(year.toString());
      return DateTime(yearInt, 1, 1);
    } catch (e) {
      return DateTime.now();
    }
  }
}

