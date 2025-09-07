import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ArtistDetailScreen extends StatelessWidget {
  final String artistId;
  
  const ArtistDetailScreen({
    super.key,
    required this.artistId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Text(
          'Artist Detail Screen\nID: $artistId',
          style: const TextStyle(color: AppColors.primaryText),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

