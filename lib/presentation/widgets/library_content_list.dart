import 'package:flutter/material.dart';
import '../blocs/library/library_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../domain/models/playlist.dart';
import '../../domain/models/album.dart';
import '../../domain/models/artist.dart';
import '../../domain/models/track.dart';

class LibraryContentList extends StatelessWidget {
  final List<dynamic> items;
  final LibraryViewType viewType;
  final LibrarySortType sortType;

  const LibraryContentList({
    super.key,
    required this.items,
    required this.viewType,
    required this.sortType,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.library_music,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSizes.spaceMD),
            Text(
              'Your library is empty',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
            Text(
              'Start by saving songs, albums, and playlists',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      );
    }

    if (viewType == LibraryViewType.grid) {
      return _buildGridView(context);
    } else {
      return _buildListView(context);
    }
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildListItem(context, item);
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSizes.horizontalPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.spaceMD,
        mainAxisSpacing: AppSizes.spaceMD,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildGridItem(context, item);
      },
    );
  }

  Widget _buildListItem(BuildContext context, dynamic item) {
    if (item is Playlist) {
      return _buildPlaylistListItem(context, item);
    } else if (item is Album) {
      return _buildAlbumListItem(context, item);
    } else if (item is Artist) {
      return _buildArtistListItem(context, item);
    } else if (item is Track) {
      return _buildTrackListItem(context, item);
    }
    return const SizedBox.shrink();
  }

  Widget _buildGridItem(BuildContext context, dynamic item) {
    if (item is Playlist) {
      return _buildPlaylistGridItem(context, item);
    } else if (item is Album) {
      return _buildAlbumGridItem(context, item);
    } else if (item is Artist) {
      return _buildArtistGridItem(context, item);
    }
    return const SizedBox.shrink();
  }

  Widget _buildPlaylistListItem(BuildContext context, Playlist playlist) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: AppSizes.spaceSM),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          color: AppColors.cardBackground,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          child: playlist.imageUrl != null
              ? Image.network(
                  playlist.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.library_music,
                      color: AppColors.secondaryText,
                    );
                  },
                )
              : Icon(
                  Icons.library_music,
                  color: AppColors.secondaryText,
                ),
        ),
      ),
      title: Text(
        playlist.name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.primaryText,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${playlist.privacyString} • ${playlist.owner.displayName}',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.secondaryText,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        color: AppColors.secondaryText,
        onPressed: () {
          // Show playlist options
        },
      ),
      onTap: () {
        // Navigate to playlist
      },
    );
  }

  Widget _buildAlbumListItem(BuildContext context, Album album) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: AppSizes.spaceSM),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          color: AppColors.cardBackground,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          child: album.imageUrl != null
              ? Image.network(
                  album.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.album,
                      color: AppColors.secondaryText,
                    );
                  },
                )
              : Icon(
                  Icons.album,
                  color: AppColors.secondaryText,
                ),
        ),
      ),
      title: Text(
        album.name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.primaryText,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${album.albumTypeDisplay} • ${album.artistsString}',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.secondaryText,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        color: AppColors.secondaryText,
        onPressed: () {
          // Show album options
        },
      ),
      onTap: () {
        // Navigate to album
      },
    );
  }

  Widget _buildArtistListItem(BuildContext context, Artist artist) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: AppSizes.spaceSM),
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: artist.imageUrl != null 
            ? NetworkImage(artist.imageUrl!) 
            : null,
        backgroundColor: AppColors.cardBackground,
        child: artist.imageUrl == null 
            ? Icon(
                Icons.person,
                color: AppColors.secondaryText,
              )
            : null,
      ),
      title: Text(
        artist.name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.primaryText,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Artist • ${artist.followersString} followers',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.secondaryText,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        color: AppColors.secondaryText,
        onPressed: () {
          // Show artist options
        },
      ),
      onTap: () {
        // Navigate to artist
      },
    );
  }

  Widget _buildTrackListItem(BuildContext context, Track track) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: AppSizes.spaceSM),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          color: AppColors.cardBackground,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          child: track.imageUrl != null
              ? Image.network(
                  track.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.music_note,
                      color: AppColors.secondaryText,
                    );
                  },
                )
              : Icon(
                  Icons.music_note,
                  color: AppColors.secondaryText,
                ),
        ),
      ),
      title: Text(
        track.name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.primaryText,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        track.artistsString,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.secondaryText,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              track.isLiked ? Icons.favorite : Icons.favorite_border,
              color: track.isLiked ? AppColors.spotifyGreen : AppColors.secondaryText,
            ),
            onPressed: () {
              // Toggle like
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: AppColors.secondaryText,
            onPressed: () {
              // Show track options
            },
          ),
        ],
      ),
      onTap: () {
        // Play track
      },
    );
  }

  Widget _buildPlaylistGridItem(BuildContext context, Playlist playlist) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        color: AppColors.cardBackground.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                color: AppColors.cardBackground,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                child: playlist.imageUrl != null
                    ? Image.network(
                        playlist.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.library_music,
                            size: 48,
                            color: AppColors.secondaryText,
                          );
                        },
                      )
                    : Icon(
                        Icons.library_music,
                        size: 48,
                        color: AppColors.secondaryText,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.spaceSM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playlist.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
    );
  }

  Widget _buildAlbumGridItem(BuildContext context, Album album) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        color: AppColors.cardBackground.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                color: AppColors.cardBackground,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                child: album.imageUrl != null
                    ? Image.network(
                        album.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.album,
                            size: 48,
                            color: AppColors.secondaryText,
                          );
                        },
                      )
                    : Icon(
                        Icons.album,
                        size: 48,
                        color: AppColors.secondaryText,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.spaceSM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  album.artistsString,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistGridItem(BuildContext context, Artist artist) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        color: AppColors.cardBackground.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spaceMD),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: artist.imageUrl != null 
                    ? NetworkImage(artist.imageUrl!) 
                    : null,
                backgroundColor: AppColors.cardBackground,
                child: artist.imageUrl == null 
                    ? Icon(
                        Icons.person,
                        size: 48,
                        color: AppColors.secondaryText,
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.spaceSM),
            child: Column(
              children: [
                Text(
                  artist.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryText,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
