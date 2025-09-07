import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class PlayerQueueButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PlayerQueueButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.queue_music,
        color: AppColors.secondaryText,
        size: AppSizes.iconMD,
      ),
      tooltip: 'Queue',
    );
  }
}