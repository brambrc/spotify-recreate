import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/playlist.dart';
import '../../domain/models/track.dart';
import '../../domain/models/artist.dart';
import '../../domain/models/album.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../blocs/player/player_bloc.dart';
import 'cached_image.dart';

class QuickAccessGrid extends StatelessWidget {
  final List<Playlist> playlists;

  const QuickAccessGrid({
    super.key,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.spaceSM,
        mainAxisSpacing: AppSizes.spaceSM,
        childAspectRatio: 3,
      ),
      itemCount: playlists.length > 6 ? 6 : playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return _buildQuickAccessItem(context, playlist);
      },
    );
  }

  Widget _buildQuickAccessItem(BuildContext context, Playlist playlist) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Show detailed information about the playlist and option to play
          _showPlaylistDetails(context, playlist);
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusXS),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          ),
          child: Row(
            children: [
              // Album Art
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.radiusXS),
                  bottomLeft: Radius.circular(AppSizes.radiusXS),
                ),
                child: CachedImage(
                  imageUrl: playlist.imageUrl,
                  width: 56,
                  height: 56,
                ),
              ),
              
              // Playlist Name
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceMD,
                  ),
                  child: Text(
                    playlist.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPlaylistDetails(BuildContext context, Playlist playlist) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(AppSizes.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSizes.spaceLG),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryText,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              // Playlist header
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                    child: CachedImage(
                      imageUrl: playlist.imageUrl,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlist.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceXS),
                        Text(
                          'By ${playlist.owner.displayName}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceXS),
                        Text(
                          '${playlist.totalTracks} songs',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppSizes.spaceLG),
              
              // Action buttons
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Play the first track in the playlist if available
                        if (playlist.tracks != null && playlist.tracks!.isNotEmpty) {
                          _playTrack(context, playlist.tracks!.first, playlist.tracks!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${playlist.name} - No tracks available'),
                              backgroundColor: AppColors.spotifyGreen,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.spotifyGreen,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceMD),
                        minimumSize: const Size(120, 48),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceSM),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Shuffling ${playlist.name}'),
                            backgroundColor: AppColors.spotifyGreen,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cardBackground,
                        foregroundColor: AppColors.primaryText,
                        side: const BorderSide(color: AppColors.secondaryText),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.spaceMD,
                          horizontal: AppSizes.spaceSM,
                        ),
                        minimumSize: const Size(48, 48),
                      ),
                      child: const Icon(Icons.shuffle),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppSizes.spaceLG),
              
              // Songs list
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: playlist.tracks?.length ?? 5, // Show 5 mock items if no tracks
                  itemBuilder: (context, index) {
                    if (playlist.tracks != null && index < playlist.tracks!.length) {
                      final track = playlist.tracks![index];
                      return _buildTrackItem(context, track, index + 1);
                    } else {
                      // Mock track items
                      return _buildMockTrackItem(context, index + 1);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackItem(BuildContext context, dynamic track, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Playing track $index'),
              backgroundColor: AppColors.spotifyGreen,
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceXS),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: Text(
                  '$index',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spaceMD),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                child: CachedImage(
                  imageUrl: track.imageUrl,
                  width: 48,
                  height: 48,
                ),
              ),
              const SizedBox(width: AppSizes.spaceMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.name ?? 'Unknown Track',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      track.artistsString ?? 'Unknown Artist',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMockTrackItem(BuildContext context, int index) {
    final mockTracks = [
      'Blinding Lights',
      'Shape of You', 
      'Bad Guy',
      'Watermelon Sugar',
      'As It Was',
    ];
    
    final mockArtists = [
      'The Weeknd',
      'Ed Sheeran',
      'Billie Eilish', 
      'Harry Styles',
      'Harry Styles',
    ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Create a demo track and play it
          final mockArtist = Artist(
            id: 'demo_artist_$index',
            name: mockArtists[(index - 1) % mockArtists.length],
            genres: ['Demo'],
            popularity: 85,
            followers: 1000000,
            images: ['https://picsum.photos/300/300?random=$index'],
            isFollowing: false,
          );
          
          final mockAlbum = Album(
            id: 'demo_album_$index',
            name: 'Demo Album',
            artists: [mockArtist],
            albumType: 'album',
            totalTracks: 1,
            images: ['https://picsum.photos/300/300?random=$index'],
            releaseDate: DateTime.now(),
            releaseDatePrecision: 'day',
            genres: ['Demo'],
            popularity: 85,
            isSaved: false,
          );
          
          final demoTrack = Track(
            id: 'demo_$index',
            name: mockTracks[(index - 1) % mockTracks.length],
            artists: [mockArtist],
            album: mockAlbum,
            durationMs: 30000, // 30 seconds preview
            explicit: false,
            popularity: 85,
            isLocal: false,
            isPlayable: true,
            isLiked: false,
            previewUrl: 'https://www.soundjay.com/misc/sounds/bell-ringing-05.wav', // Demo audio URL
          );
          
          _playTrack(context, demoTrack, [demoTrack]);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceXS),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: Text(
                  '$index',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.spaceMD),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                ),
                child: const Icon(
                  Icons.music_note,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: AppSizes.spaceMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mockTracks[(index - 1) % mockTracks.length],
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      mockArtists[(index - 1) % mockArtists.length],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added ${mockTracks[(index - 1) % mockTracks.length]} to liked songs'),
                      backgroundColor: AppColors.spotifyGreen,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _playTrack(BuildContext context, Track track, List<Track> playlist) {
    // Navigate to player screen and start playing
    context.read<PlayerBloc>().add(PlayerLoadTrackEvent(
      track: track,
      queue: playlist,
      startIndex: playlist.indexOf(track),
    ));
    
    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Now playing: ${track.name}'),
        backgroundColor: AppColors.spotifyGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
