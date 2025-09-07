import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import 'cached_image.dart';

class PlayerArtwork extends StatelessWidget {
  final String? imageUrl;
  final bool isPlaying;

  const PlayerArtwork({
    super.key,
    this.imageUrl,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        margin: const EdgeInsets.all(AppSizes.sectionPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? CachedImage(
                  imageUrl: imageUrl!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 300,
                  height: 300,
                  color: AppColors.cardBackground,
                  child: const Icon(
                    Icons.music_note,
                    size: 80,
                    color: AppColors.secondaryText,
                  ),
                ),
        ),
      ),
    );
  }
}