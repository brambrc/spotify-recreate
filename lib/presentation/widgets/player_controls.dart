import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../blocs/player/player_bloc.dart';

class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final bool isShuffled;
  final RepeatMode repeatMode;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onShuffle;
  final VoidCallback onRepeat;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.isShuffled,
    required this.repeatMode,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
    required this.onShuffle,
    required this.onRepeat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Secondary controls (shuffle and repeat)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Shuffle button
            IconButton(
              onPressed: onShuffle,
              icon: Icon(
                Icons.shuffle,
                color: isShuffled ? AppColors.spotifyGreen : AppColors.secondaryText,
                size: AppSizes.iconMD,
              ),
            ),
            
            // Repeat button
            IconButton(
              onPressed: onRepeat,
              icon: Icon(
                _getRepeatIcon(),
                color: repeatMode != RepeatMode.off ? AppColors.spotifyGreen : AppColors.secondaryText,
                size: AppSizes.iconMD,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppSizes.spaceMD),
        
        // Main controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Previous button
            IconButton(
              onPressed: onPrevious,
              icon: const Icon(
                Icons.skip_previous,
                color: AppColors.primaryText,
                size: AppSizes.iconLG,
              ),
            ),
            
            // Play/Pause button
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.primaryText,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onPlayPause,
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: AppColors.primaryBackground,
                  size: AppSizes.iconLG,
                ),
              ),
            ),
            
            // Next button
            IconButton(
              onPressed: onNext,
              icon: const Icon(
                Icons.skip_next,
                color: AppColors.primaryText,
                size: AppSizes.iconLG,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  IconData _getRepeatIcon() {
    switch (repeatMode) {
      case RepeatMode.off:
        return Icons.repeat;
      case RepeatMode.all:
        return Icons.repeat;
      case RepeatMode.one:
        return Icons.repeat_one;
    }
  }
}