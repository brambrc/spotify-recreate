import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/track.dart';
import '../../domain/models/artist.dart';
import '../../domain/models/album.dart';
import '../../domain/models/playlist.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../blocs/player/player_bloc.dart';
import 'cached_image.dart';

class SearchResultsView extends StatelessWidget {
  final String query;
  final List<Track> tracks;
  final List<Artist> artists;
  final List<Album> albums;
  final List<Playlist> playlists;

  const SearchResultsView({
    super.key,
    required this.query,
    required this.tracks,
    required this.artists,
    required this.albums,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    print('SearchResultsView building with: ${tracks.length} tracks, ${artists.length} artists, ${albums.length} albums, ${playlists.length} playlists for query: $query');
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search results header
          Text(
            'Search results for "$query"',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          // Songs section
          if (tracks.isNotEmpty) ...[
            Text(
              'Songs (${tracks.length})',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),
            ...tracks.map((track) => _buildTrackItem(context, track)),
            const SizedBox(height: AppSizes.spaceLG),
          ],

          // Artists section
          if (artists.isNotEmpty) ...[
            Text(
              'Artists (${artists.length})',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: artists.length,
                itemBuilder: (context, index) => _buildArtistCard(context, artists[index]),
              ),
            ),
            const SizedBox(height: AppSizes.spaceLG),
          ],

          // Albums section
          if (albums.isNotEmpty) ...[
            Text(
              'Albums (${albums.length})',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: albums.length,
                itemBuilder: (context, index) => _buildAlbumCard(context, albums[index]),
              ),
            ),
            const SizedBox(height: AppSizes.spaceLG),
          ],

          // Playlists section
          if (playlists.isNotEmpty) ...[
            Text(
              'Playlists (${playlists.length})',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: playlists.length,
                itemBuilder: (context, index) => _buildPlaylistCard(context, playlists[index]),
              ),
            ),
          ],

          // No results message
          if (tracks.isEmpty && artists.isEmpty && albums.isEmpty && playlists.isEmpty) ...[
            Center(
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.spaceLG * 2),
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(height: AppSizes.spaceMD),
                  Text(
                    'No results found for "$query"',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceSM),
                  Text(
                    'Try different keywords or check spelling',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.tertiaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrackItem(BuildContext context, Track track) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Actually play the track
          context.read<PlayerBloc>().add(PlayerLoadTrackEvent(
            track: track,
            queue: tracks,
            startIndex: tracks.indexOf(track),
          ));
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Now playing: ${track.name}'),
              backgroundColor: AppColors.spotifyGreen,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceXS),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                child: CachedImage(
                  imageUrl: track.imageUrl,
                  width: 56,
                  height: 56,
                ),
              ),
              const SizedBox(width: AppSizes.spaceMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      track.artistsString,
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
                      content: Text('Added ${track.name} to playlist'),
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

  Widget _buildArtistCard(BuildContext context, Artist artist) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${artist.name}'),
              backgroundColor: AppColors.spotifyGreen,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Container(
          width: 140,
          margin: const EdgeInsets.only(right: AppSizes.spaceMD),
          child: Column(
            children: [
              ClipOval(
                child: CachedImage(
                  imageUrl: artist.images.isNotEmpty ? artist.images.first : null,
                  width: 140,
                  height: 140,
                ),
              ),
              const SizedBox(height: AppSizes.spaceSM),
              Text(
                artist.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                'Artist',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumCard(BuildContext context, Album album) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${album.name}'),
              backgroundColor: AppColors.spotifyGreen,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Container(
          width: 140,
          margin: const EdgeInsets.only(right: AppSizes.spaceMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                child: CachedImage(
                  imageUrl: album.images.isNotEmpty ? album.images.first : null,
                  width: 140,
                  height: 140,
                ),
              ),
              const SizedBox(height: AppSizes.spaceSM),
              Text(
                album.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                album.artists.first.name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondaryText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaylistCard(BuildContext context, Playlist playlist) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${playlist.name}'),
              backgroundColor: AppColors.spotifyGreen,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Container(
          width: 140,
          margin: const EdgeInsets.only(right: AppSizes.spaceMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                child: CachedImage(
                  imageUrl: playlist.imageUrl,
                  width: 140,
                  height: 140,
                ),
              ),
              const SizedBox(height: AppSizes.spaceSM),
              Text(
                playlist.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'By ${playlist.owner.displayName}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondaryText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}