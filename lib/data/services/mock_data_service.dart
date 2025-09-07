import '../../domain/models/track.dart';
import '../../domain/models/album.dart';
import '../../domain/models/artist.dart';
import '../../domain/models/playlist.dart';
import '../../domain/models/user.dart';

class MockDataService {
  static MockDataService? _instance;
  static MockDataService get instance => _instance ??= MockDataService._();
  MockDataService._();

  // Mock Artists
  static final List<Artist> _artists = [
    Artist(
      id: 'artist_1',
      name: 'The Weeknd',
      genres: ['Pop', 'R&B', 'Alternative'],
      popularity: 95,
      followers: 15420000,
      images: ['https://picsum.photos/300/300?random=101'],
      isFollowing: true,
      description: 'Grammy-winning Canadian singer, songwriter, and record producer.',
    ),
    Artist(
      id: 'artist_2',
      name: 'Billie Eilish',
      genres: ['Pop', 'Alternative', 'Electropop'],
      popularity: 93,
      followers: 12850000,
      images: ['https://picsum.photos/300/300?random=102'],
      isFollowing: false,
      description: 'American singer and songwriter known for her unique style.',
    ),
    Artist(
      id: 'artist_3',
      name: 'Drake',
      genres: ['Hip Hop', 'Rap', 'Pop'],
      popularity: 97,
      followers: 18200000,
      images: ['https://picsum.photos/300/300?random=103'],
      isFollowing: true,
      description: 'Canadian rapper, singer, and actor.',
    ),
    Artist(
      id: 'artist_4',
      name: 'Taylor Swift',
      genres: ['Pop', 'Country', 'Alternative'],
      popularity: 98,
      followers: 21500000,
      images: ['https://picsum.photos/300/300?random=104'],
      isFollowing: true,
      description: 'American singer-songwriter known for narrative songs.',
    ),
    Artist(
      id: 'artist_5',
      name: 'Bad Bunny',
      genres: ['Reggaeton', 'Latin Trap', 'Latin Pop'],
      popularity: 96,
      followers: 19800000,
      images: ['https://picsum.photos/300/300?random=105'],
      isFollowing: false,
      description: 'Puerto Rican rapper and singer.',
    ),
    Artist(
      id: 'artist_6',
      name: 'Dua Lipa',
      genres: ['Pop', 'Dance Pop', 'Electronic'],
      popularity: 91,
      followers: 14200000,
      images: ['https://picsum.photos/300/300?random=106'],
      isFollowing: true,
      description: 'English singer and songwriter.',
    ),
    Artist(
      id: 'artist_7',
      name: 'Post Malone',
      genres: ['Hip Hop', 'Pop', 'Rock'],
      popularity: 89,
      followers: 13600000,
      images: ['https://picsum.photos/300/300?random=107'],
      isFollowing: false,
      description: 'American rapper, singer, and songwriter.',
    ),
    Artist(
      id: 'artist_8',
      name: 'Ariana Grande',
      genres: ['Pop', 'R&B'],
      popularity: 92,
      followers: 16700000,
      images: ['https://picsum.photos/300/300?random=108'],
      isFollowing: true,
      description: 'American singer, songwriter, and actress.',
    ),
    Artist(
      id: 'artist_9',
      name: 'Ed Sheeran',
      genres: ['Pop', 'Folk', 'Acoustic'],
      popularity: 90,
      followers: 15900000,
      images: ['https://picsum.photos/300/300?random=109'],
      isFollowing: true,
      description: 'English singer-songwriter.',
    ),
    Artist(
      id: 'artist_10',
      name: 'Kendrick Lamar',
      genres: ['Hip Hop', 'Rap', 'Jazz Rap'],
      popularity: 88,
      followers: 12400000,
      images: ['https://picsum.photos/300/300?random=110'],
      isFollowing: false,
      description: 'American rapper and songwriter.',
    ),
  ];

  // Mock Albums
  static final List<Album> _albums = [
    Album(
      id: 'album_1',
      name: 'After Hours',
      artists: [_artists[0]], // The Weeknd
      albumType: 'album',
      totalTracks: 14,
      images: ['https://picsum.photos/300/300?random=201'],
      releaseDate: DateTime(2020, 3, 20),
      releaseDatePrecision: 'day',
      genres: ['Pop', 'R&B', 'Alternative'],
      label: 'XO / Republic Records',
      popularity: 95,
      isSaved: true,
      description: 'The fourth studio album by Canadian singer The Weeknd.',
    ),
    Album(
      id: 'album_2',
      name: 'Happier Than Ever',
      artists: [_artists[1]], // Billie Eilish
      albumType: 'album',
      totalTracks: 16,
      images: ['https://picsum.photos/300/300?random=202'],
      releaseDate: DateTime(2021, 7, 30),
      releaseDatePrecision: 'day',
      genres: ['Pop', 'Alternative', 'Electropop'],
      label: 'Darkroom / Interscope Records',
      popularity: 93,
      isSaved: true,
      description: 'The second studio album by American singer Billie Eilish.',
    ),
    Album(
      id: 'album_3',
      name: 'Certified Lover Boy',
      artists: [_artists[2]], // Drake
      albumType: 'album',
      totalTracks: 21,
      images: ['https://picsum.photos/300/300?random=203'],
      releaseDate: DateTime(2021, 9, 3),
      releaseDatePrecision: 'day',
      genres: ['Hip Hop', 'Rap', 'Pop'],
      label: 'OVO Sound / Republic Records',
      popularity: 97,
      isSaved: false,
      description: 'The sixth studio album by Canadian rapper Drake.',
    ),
    Album(
      id: 'album_4',
      name: 'Midnights',
      artists: [_artists[3]], // Taylor Swift
      albumType: 'album',
      totalTracks: 13,
      images: ['https://picsum.photos/300/300?random=204'],
      releaseDate: DateTime(2022, 10, 21),
      releaseDatePrecision: 'day',
      genres: ['Pop', 'Alternative', 'Synth-pop'],
      label: 'Republic Records',
      popularity: 98,
      isSaved: true,
      description: 'The tenth studio album by American singer-songwriter Taylor Swift.',
    ),
    Album(
      id: 'album_5',
      name: 'Un Verano Sin Ti',
      artists: [_artists[4]], // Bad Bunny
      albumType: 'album',
      totalTracks: 23,
      images: ['https://picsum.photos/300/300?random=505'],
      releaseDate: DateTime(2022, 5, 6),
      releaseDatePrecision: 'day',
      genres: ['Reggaeton', 'Latin Trap', 'Latin Pop'],
      label: 'Rimas Entertainment',
      popularity: 96,
      isSaved: false,
      description: 'The fourth studio album by Puerto Rican rapper Bad Bunny.',
    ),
    Album(
      id: 'album_6',
      name: 'Future Nostalgia',
      artists: [_artists[5]], // Dua Lipa
      albumType: 'album',
      totalTracks: 11,
      images: ['https://picsum.photos/300/300?random=205'],
      releaseDate: DateTime(2020, 3, 27),
      releaseDatePrecision: 'day',
      genres: ['Pop', 'Dance Pop', 'Electronic'],
      label: 'Warner Records',
      popularity: 91,
      isSaved: true,
      description: 'The second studio album by English singer Dua Lipa.',
    ),
  ];

  // Mock Tracks
  static final List<Track> _tracks = [
    Track(
      id: 'track_1',
      name: 'Blinding Lights',
      artists: [_artists[0]], // The Weeknd
      album: _albums[0],
      durationMs: 200040,
      explicit: false,
      previewUrl: 'https://www.soundjay.com/misc/sounds/bell-ringing-05.wav',
      popularity: 95,
      trackNumber: 2,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 5)),
      isLiked: true,
    ),
    Track(
      id: 'track_2',
      name: 'Happier Than Ever',
      artists: [_artists[1]], // Billie Eilish
      album: _albums[1],
      durationMs: 298933,
      explicit: false,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-07a.wav',
      popularity: 93,
      trackNumber: 16,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 3)),
      isLiked: true,
    ),
    Track(
      id: 'track_3',
      name: 'God\'s Plan',
      artists: [_artists[2]], // Drake
      album: _albums[2],
      durationMs: 198973,
      explicit: false,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-09.wav',
      popularity: 97,
      trackNumber: 5,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 7)),
      isLiked: false,
    ),
    Track(
      id: 'track_4',
      name: 'Anti-Hero',
      artists: [_artists[3]], // Taylor Swift
      album: _albums[3],
      durationMs: 200690,
      explicit: false,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-10.wav',
      popularity: 98,
      trackNumber: 3,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 1)),
      isLiked: true,
    ),
    Track(
      id: 'track_5',
      name: 'Me Porto Bonito',
      artists: [_artists[4]], // Bad Bunny
      album: _albums[4],
      durationMs: 167000,
      explicit: true,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-11.wav',
      popularity: 96,
      trackNumber: 8,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 2)),
      isLiked: false,
    ),
    Track(
      id: 'track_6',
      name: 'Levitating',
      artists: [_artists[5]], // Dua Lipa
      album: _albums[5],
      durationMs: 203064,
      explicit: false,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-12.wav',
      popularity: 91,
      trackNumber: 3,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 4)),
      isLiked: true,
    ),
    Track(
      id: 'track_7',
      name: 'Circles',
      artists: [_artists[6]], // Post Malone
      durationMs: 215280,
      explicit: false,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-13.wav',
      popularity: 89,
      trackNumber: 1,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 6)),
      isLiked: true,
    ),
    Track(
      id: 'track_8',
      name: 'positions',
      artists: [_artists[7]], // Ariana Grande
      durationMs: 172267,
      explicit: false,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-14.wav',
      popularity: 92,
      trackNumber: 1,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 8)),
      isLiked: false,
    ),
    Track(
      id: 'track_9',
      name: 'Shape of You',
      artists: [_artists[8]], // Ed Sheeran
      durationMs: 233713,
      explicit: false,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-15.wav',
      popularity: 90,
      trackNumber: 4,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 9)),
      isLiked: true,
    ),
    Track(
      id: 'track_10',
      name: 'HUMBLE.',
      artists: [_artists[9]], // Kendrick Lamar
      durationMs: 177000,
      explicit: true,
      previewUrl: 'https://www.soundjay.com/misc/sounds/beep-16.wav',
      popularity: 88,
      trackNumber: 2,
      isLocal: false,
      isPlayable: true,
      addedAt: DateTime.now().subtract(const Duration(days: 10)),
      isLiked: false,
    ),
    // Additional trending tracks
    Track(
      id: 'track_11',
      name: 'As It Was',
      artists: [Artist(
        id: 'artist_11',
        name: 'Harry Styles',
        genres: ['Pop', 'Rock'],
        popularity: 94,
        followers: 8500000,
        images: ['https://picsum.photos/300/300?random=301'],
        isFollowing: true,
      )],
      durationMs: 167000,
      explicit: false,
      popularity: 94,
      isLocal: false,
      isPlayable: true,
      isLiked: true,
    ),
    Track(
      id: 'track_12',
      name: 'Heat Waves',
      artists: [Artist(
        id: 'artist_12',
        name: 'Glass Animals',
        genres: ['Indie Pop', 'Alternative'],
        popularity: 87,
        followers: 3200000,
        images: ['https://picsum.photos/300/300?random=302'],
        isFollowing: false,
      )],
      durationMs: 238640,
      explicit: false,
      popularity: 87,
      isLocal: false,
      isPlayable: true,
      isLiked: true,
    ),
    // More diverse tracks for better search results
    Track(
      id: 'track_13',
      name: 'Stay',
      artists: [Artist(
        id: 'artist_13',
        name: 'The Kid LAROI',
        genres: ['Hip Hop', 'Pop'],
        popularity: 89,
        followers: 4200000,
        images: ['https://picsum.photos/300/300?random=303'],
        isFollowing: false,
      ), Artist(
        id: 'artist_14',
        name: 'Justin Bieber',
        genres: ['Pop', 'R&B'],
        popularity: 95,
        followers: 22000000,
        images: ['https://picsum.photos/300/300?random=304'],
        isFollowing: true,
      )],
      durationMs: 141806,
      explicit: false,
      popularity: 92,
      isLocal: false,
      isPlayable: true,
      isLiked: false,
    ),
    Track(
      id: 'track_14',
      name: 'Industry Baby',
      artists: [Artist(
        id: 'artist_15',
        name: 'Lil Nas X',
        genres: ['Hip Hop', 'Pop Rap'],
        popularity: 88,
        followers: 7300000,
        images: ['https://picsum.photos/300/300?random=305'],
        isFollowing: false,
      )],
      durationMs: 212000,
      explicit: true,
      popularity: 88,
      isLocal: false,
      isPlayable: true,
      isLiked: true,
    ),
    Track(
      id: 'track_15',
      name: 'Good 4 U',
      artists: [Artist(
        id: 'artist_16',
        name: 'Olivia Rodrigo',
        genres: ['Pop', 'Alternative Rock'],
        popularity: 91,
        followers: 9800000,
        images: ['https://picsum.photos/300/300?random=306'],
        isFollowing: true,
      )],
      durationMs: 178147,
      explicit: false,
      popularity: 91,
      isLocal: false,
      isPlayable: true,
      isLiked: true,
    ),
  ];

  // Create mock users first
  static final User _spotifyUser = User(
    id: 'spotify',
    displayName: 'Spotify',
    images: ['https://picsum.photos/300/300?random=401'],
    country: 'US',
    followers: 0,
    following: 0,
    product: 'premium',
    isCurrentUser: false,
  );

  // Mock Playlists
  static final List<Playlist> _playlists = [
    Playlist(
      id: 'playlist_1',
      name: 'Today\'s Top Hits',
      description: 'The most played songs in the US right now',
      owner: _spotifyUser,
      images: ['https://picsum.photos/300/300?random=501'],
      totalTracks: 50,
      public: true,
      collaborative: false,
      isFollowing: true,
      isPinned: false,
    ),
    Playlist(
      id: 'playlist_2',
      name: 'RapCaviar',
      description: 'Music from culture\'s biggest artists and next biggest artists',
      owner: _spotifyUser,
      images: ['https://picsum.photos/300/300?random=502'],
      totalTracks: 67,
      public: true,
      collaborative: false,
      isFollowing: true,
      isPinned: false,
    ),
    Playlist(
      id: 'playlist_3',
      name: 'My Favorites',
      description: 'Songs I can\'t stop listening to',
      owner: _currentUser,
      images: ['https://picsum.photos/300/300?random=503'],
      totalTracks: 34,
      public: false,
      collaborative: false,
      isFollowing: true,
      isPinned: true,
    ),
    Playlist(
      id: 'playlist_4',
      name: 'Chill Vibes',
      description: 'Relax and unwind with these mellow tracks',
      owner: _currentUser,
      images: ['https://picsum.photos/300/300?random=504'],
      totalTracks: 42,
      public: true,
      collaborative: true,
      isFollowing: true,
      isPinned: false,
    ),
    Playlist(
      id: 'playlist_5',
      name: 'Workout Mix',
      description: 'High energy songs to keep you motivated',
      owner: _currentUser,
      images: ['https://picsum.photos/300/300?random=505'],
      totalTracks: 28,
      public: false,
      collaborative: false,
      isFollowing: true,
      isPinned: false,
    ),
  ];

  // Mock User
  static final User _currentUser = User(
    id: 'user_1',
    displayName: 'John Doe',
    email: 'john.doe@example.com',
    images: ['https://picsum.photos/300/300?random=401'],
    country: 'US',
    followers: 42,
    following: 125,
    product: 'premium',
    isCurrentUser: true,
    birthDate: DateTime(1995, 6, 15),
  );

  // Genre categories for search
  static final List<Map<String, dynamic>> _genres = [
    {
      'name': 'Pop',
      'color': '0xFF8E44AD',
      'image': 'https://i.scdn.co/image/ab67706f00000002df55e326ed1eced08af65890',
    },
    {
      'name': 'Hip-Hop',
      'color': '0xFFE74C3C',
      'image': 'https://i.scdn.co/image/ab67706f00000002a0e83087aa77e12d9e6d5b60',
    },
    {
      'name': 'Rock',
      'color': '0xFF34495E',
      'image': 'https://i.scdn.co/image/ab67706f00000002ca5a7517156021292e5663a6',
    },
    {
      'name': 'R&B',
      'color': '0xFF9B59B6',
      'image': 'https://i.scdn.co/image/ab67706f000000020689c0cf12a615de6c52de55',
    },
    {
      'name': 'Electronic',
      'color': '0xFF3498DB',
      'image': 'https://i.scdn.co/image/ab67706f000000029bb6af539749bbc2cc109cef',
    },
    {
      'name': 'Alternative',
      'color': '0xFF27AE60',
      'image': 'https://i.scdn.co/image/ab67706f00000002b7c0fbb7a39c41f5bbcc8ef1',
    },
    {
      'name': 'Country',
      'color': '0xFFE67E22',
      'image': 'https://i.scdn.co/image/ab67706f000000026a3a6b6d68b1a87b7f9c5d45',
    },
    {
      'name': 'Latin',
      'color': '0xFFE91E63',
      'image': 'https://i.scdn.co/image/ab67706f000000024d31e3547a8da47be5a7e67f',
    },
    {
      'name': 'Jazz',
      'color': '0xFF795548',
      'image': 'https://i.scdn.co/image/ab67706f00000002b5c4ced4a31b6cef3e4b5d6c',
    },
    {
      'name': 'Classical',
      'color': '0xFF607D8B',
      'image': 'https://i.scdn.co/image/ab67706f000000025c3b9f11c25b4eb5a7c8d5d4',
    },
  ];

  // Recent searches
  static final List<String> _recentSearches = [
    'The Weeknd',
    'Billie Eilish',
    'chill music',
    'workout playlist',
    'Taylor Swift',
    'new releases',
  ];

  // Getters
  List<Artist> get artists => List.unmodifiable(_artists);
  List<Album> get albums => List.unmodifiable(_albums);
  List<Track> get tracks => List.unmodifiable(_tracks);
  List<Playlist> get playlists => List.unmodifiable(_playlists);
  User get currentUser => _currentUser;
  List<Map<String, dynamic>> get genres => List.unmodifiable(_genres);
  List<String> get recentSearches => List.unmodifiable(_recentSearches);

  // Get featured playlists for home screen
  List<Playlist> getFeaturedPlaylists() {
    return _playlists.take(3).toList();
  }

  // Get recently played tracks
  List<Track> getRecentlyPlayedTracks() {
    return _tracks.where((track) => track.addedAt != null).take(6).toList();
  }

  // Get popular tracks
  List<Track> getPopularTracks() {
    final sortedTracks = List<Track>.from(_tracks);
    sortedTracks.sort((a, b) => b.popularity.compareTo(a.popularity));
    return sortedTracks.take(10).toList();
  }

  // Get user's saved tracks (liked songs)
  List<Track> getSavedTracks() {
    return _tracks.where((track) => track.isLiked).toList();
  }

  // Get user's playlists
  List<Playlist> getUserPlaylists() {
    return _playlists.where((playlist) => playlist.isOwnedByCurrentUser).toList();
  }

  // Get followed playlists
  List<Playlist> getFollowedPlaylists() {
    return _playlists.where((playlist) => !playlist.isOwnedByCurrentUser && playlist.isFollowing).toList();
  }

  // Search functionality
  List<Track> searchTracks(String query) {
    if (query.isEmpty) return [];
    
    final lowercaseQuery = query.toLowerCase();
    return _tracks.where((track) {
      return track.name.toLowerCase().contains(lowercaseQuery) ||
             track.artistsString.toLowerCase().contains(lowercaseQuery) ||
             (track.album?.name.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  List<Artist> searchArtists(String query) {
    if (query.isEmpty) return [];
    
    final lowercaseQuery = query.toLowerCase();
    return _artists.where((artist) {
      return artist.name.toLowerCase().contains(lowercaseQuery) ||
             artist.genres.any((genre) => genre.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  List<Album> searchAlbums(String query) {
    if (query.isEmpty) return [];
    
    final lowercaseQuery = query.toLowerCase();
    return _albums.where((album) {
      return album.name.toLowerCase().contains(lowercaseQuery) ||
             album.artistsString.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<Playlist> searchPlaylists(String query) {
    if (query.isEmpty) return [];
    
    final lowercaseQuery = query.toLowerCase();
    return _playlists.where((playlist) {
      return playlist.name.toLowerCase().contains(lowercaseQuery) ||
             (playlist.description?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  // Get tracks by genre
  List<Track> getTracksByGenre(String genre) {
    return _tracks.where((track) {
      return track.artists.any((artist) => 
        artist.genres.any((g) => g.toLowerCase() == genre.toLowerCase()));
    }).toList();
  }

  // Get new releases
  List<Album> getNewReleases() {
    final sortedAlbums = List<Album>.from(_albums);
    sortedAlbums.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
    return sortedAlbums.take(6).toList();
  }

  // Get trending artists
  List<Artist> getTrendingArtists() {
    final sortedArtists = List<Artist>.from(_artists);
    sortedArtists.sort((a, b) => b.popularity.compareTo(a.popularity));
    return sortedArtists.take(8).toList();
  }

  // Add to recent searches
  void addToRecentSearches(String query) {
    _recentSearches.remove(query);
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 10) {
      _recentSearches.removeLast();
    }
  }

  // Toggle track like status
  void toggleTrackLike(String trackId) {
    final trackIndex = _tracks.indexWhere((track) => track.id == trackId);
    if (trackIndex != -1) {
      _tracks[trackIndex] = _tracks[trackIndex].copyWith(
        isLiked: !_tracks[trackIndex].isLiked,
      );
    }
  }

  // Toggle artist follow status
  void toggleArtistFollow(String artistId) {
    final artistIndex = _artists.indexWhere((artist) => artist.id == artistId);
    if (artistIndex != -1) {
      _artists[artistIndex] = _artists[artistIndex].copyWith(
        isFollowing: !_artists[artistIndex].isFollowing,
      );
    }
  }

  // Toggle playlist follow status
  void togglePlaylistFollow(String playlistId) {
    final playlistIndex = _playlists.indexWhere((playlist) => playlist.id == playlistId);
    if (playlistIndex != -1) {
      _playlists[playlistIndex] = _playlists[playlistIndex].copyWith(
        isFollowing: !_playlists[playlistIndex].isFollowing,
      );
    }
  }
}
