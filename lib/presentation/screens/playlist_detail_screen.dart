import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String playlistId;
  
  const PlaylistDetailScreen({
    super.key,
    required this.playlistId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Text(
          'Playlist Detail Screen\nID: $playlistId',
          style: const TextStyle(color: AppColors.primaryText),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

