import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AlbumDetailScreen extends StatelessWidget {
  final String albumId;
  
  const AlbumDetailScreen({
    super.key,
    required this.albumId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Text(
          'Album Detail Screen\nID: $albumId',
          style: const TextStyle(color: AppColors.primaryText),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

