import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../blocs/player/player_bloc.dart';
import '../widgets/player_artwork.dart';
import '../widgets/player_controls.dart';
import '../widgets/player_progress_bar.dart';
import '../widgets/player_queue_button.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if (state is PlayerPlayingState || state is PlayerPausedState) {
            final playerState = state as dynamic; // Cast to access properties
            return SafeArea(
              child: Column(
                children: [
                  // Top Bar
                  _buildTopBar(context, state),
                  
                  // Artwork
                  Expanded(
                    flex: 3,
                    child: PlayerArtwork(
                      imageUrl: playerState.currentTrack?.imageUrl,
                      isPlaying: state is PlayerPlayingState,
                    ),
                  ),
                  
                  // Track Info and Controls
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sectionPadding,
                      ),
                      child: Column(
                        children: [
                          // Track Info
                          _buildTrackInfo(context, state),
                          
                          const SizedBox(height: AppSizes.spaceLG),
                          
                          // Progress Bar
                          PlayerProgressBar(
                            currentPosition: playerState.position,
                            duration: playerState.duration,
                            onSeek: (position) {
                              context.read<PlayerBloc>().add(
                                PlayerSeekEvent(position),
                              );
                            },
                          ),
                          
                          const SizedBox(height: AppSizes.spaceLG),
                          
                          // Player Controls
                          PlayerControls(
                            isPlaying: state is PlayerPlayingState,
                            isShuffled: playerState.isShuffled,
                            repeatMode: playerState.repeatMode,
                            onPlayPause: () {
                              if (state is PlayerPlayingState) {
                                context.read<PlayerBloc>().add(
                                  PlayerPauseEvent(),
                                );
                              } else {
                                context.read<PlayerBloc>().add(
                                  PlayerPlayEvent(),
                                );
                              }
                            },
                            onPrevious: () {
                              context.read<PlayerBloc>().add(
                                PlayerPreviousEvent(),
                              );
                            },
                            onNext: () {
                              context.read<PlayerBloc>().add(
                                PlayerNextEvent(),
                              );
                            },
                            onShuffle: () {
                              context.read<PlayerBloc>().add(
                                PlayerShuffleToggleEvent(),
                              );
                            },
                            onRepeat: () {
                              context.read<PlayerBloc>().add(
                                PlayerRepeatToggleEvent(),
                              );
                            },
                          ),
                          
                          const SizedBox(height: AppSizes.spaceLG),
                          
                          // Bottom Actions
                          _buildBottomActions(context, state),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text(
              'No track playing',
              style: TextStyle(color: AppColors.secondaryText),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildTopBar(BuildContext context, PlayerState state) {
    final playerState = state as dynamic;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
        vertical: AppSizes.spaceMD,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primaryText,
              size: AppSizes.iconLG,
            ),
          ),
          Column(
            children: [
              Text(
                'PLAYING FROM PLAYLIST',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.tertiaryText,
                ),
              ),
              Text(
                playerState.currentPlaylist?.name ?? 'Unknown',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Show more options
            },
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.primaryText,
              size: AppSizes.iconMD,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTrackInfo(BuildContext context, PlayerState state) {
    final playerState = state as dynamic;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerState.currentTrack?.name ?? 'Unknown Track',
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spaceXS),
                  Text(
                    playerState.currentTrack?.artistsString ?? 'Unknown Artist',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                context.read<PlayerBloc>().add(
                  PlayerToggleLikeEvent(playerState.currentTrack),
                );
              },
              icon: Icon(
                playerState.currentTrack?.isLiked == true
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: playerState.currentTrack?.isLiked == true
                    ? AppColors.spotifyGreen
                    : AppColors.secondaryText,
                size: AppSizes.iconMD,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildBottomActions(BuildContext context, PlayerState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            // Show devices
          },
          icon: const Icon(
            Icons.devices,
            color: AppColors.secondaryText,
            size: AppSizes.iconMD,
          ),
        ),
        IconButton(
          onPressed: () {
            // Share
          },
          icon: const Icon(
            Icons.share,
            color: AppColors.secondaryText,
            size: AppSizes.iconMD,
          ),
        ),
        PlayerQueueButton(
          onPressed: () {
            // Show queue
          },
        ),
      ],
    );
  }
}
