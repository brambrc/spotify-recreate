import 'package:flutter/material.dart';
import '../../domain/models/playlist.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import 'cached_image.dart';

class HorizontalPlaylistList extends StatelessWidget {
  final List<Playlist> playlists;

  const HorizontalPlaylistList({
    super.key,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding,
        ),
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return _buildPlaylistCard(context, playlist);
        },
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
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.spotifyGreen,
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Container(
          width: 120,
          margin: const EdgeInsets.only(right: AppSizes.spaceSM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Album Art
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                child: CachedImage(
                  imageUrl: playlist.imageUrl,
                  width: 120,
                  height: 120,
                ),
              ),
              
              const SizedBox(height: 4),
              
              // Playlist Name
              SizedBox(
                width: 120,
                height: 20,
                child: Text(
                  playlist.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}