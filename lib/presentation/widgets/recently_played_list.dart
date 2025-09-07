import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/track.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../blocs/player/player_bloc.dart';
import 'cached_image.dart';

class RecentlyPlayedList extends StatelessWidget {
  final List<Track> tracks;

  const RecentlyPlayedList({
    super.key,
    required this.tracks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding,
        ),
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          final track = tracks[index];
          return _buildTrackCard(context, track);
        },
      ),
    );
  }

  Widget _buildTrackCard(BuildContext context, Track track) {
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
          
          // Show confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Now playing: ${track.name}'),
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.spotifyGreen,
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Container(
          width: 100,
          margin: const EdgeInsets.only(right: AppSizes.spaceSM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Album Art
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                child: CachedImage(
                  imageUrl: track.imageUrl,
                  width: 100,
                  height: 100,
                ),
              ),
              
              const SizedBox(height: 4),
              
              // Track Name
              SizedBox(
                width: 100,
                height: 16,
                child: Text(
                  track.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              // Artist Name
              SizedBox(
                width: 100,
                height: 14,
                child: Text(
                  track.artistsString,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryText,
                    fontSize: 10,
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