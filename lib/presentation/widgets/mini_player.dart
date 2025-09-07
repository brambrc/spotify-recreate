import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/track.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../blocs/player/player_bloc.dart';
import 'cached_image.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerPlayingState || state is PlayerPausedState) {
          final playerState = state as dynamic;
          final track = playerState.currentTrack as Track?;
          final isPlaying = state is PlayerPlayingState;

          if (track == null) return const SizedBox.shrink();

          return Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              border: Border(
                top: BorderSide(
                  color: AppColors.secondaryText.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Navigate to full player screen
                  context.push('/player');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding,
                    vertical: 6.0,
                  ),
                  child: Row(
                    children: [
                      // Album art
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                        child: CachedImage(
                          imageUrl: track.imageUrl,
                          width: 44,
                          height: 44,
                        ),
                      ),
                      
                      const SizedBox(width: AppSizes.spaceMD),
                      
                      // Track info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              track.name,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              track.artistsString,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.secondaryText,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      
                      // Player controls
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Like button
                          IconButton(
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                            onPressed: () {
                              context.read<PlayerBloc>().add(
                                PlayerToggleLikeEvent(track),
                              );
                            },
                            icon: Icon(
                              track.isLiked ? Icons.favorite : Icons.favorite_border,
                              color: track.isLiked 
                                  ? AppColors.spotifyGreen 
                                  : AppColors.secondaryText,
                              size: 18,
                            ),
                          ),
                          
                          // Play/Pause button
                          IconButton(
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                            onPressed: () {
                              if (isPlaying) {
                                context.read<PlayerBloc>().add(PlayerPauseEvent());
                              } else {
                                context.read<PlayerBloc>().add(PlayerPlayEvent());
                              }
                            },
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: AppColors.primaryText,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}