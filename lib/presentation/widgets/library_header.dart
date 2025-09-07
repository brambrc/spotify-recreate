import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/services/mock_data_service.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mockDataService = MockDataService.instance;
    final currentUser = mockDataService.currentUser;
    final likedSongs = mockDataService.getSavedTracks();

    return Column(
      children: [
        // Header with Profile and Search
        Padding(
          padding: const EdgeInsets.all(AppSizes.horizontalPadding),
          child: Row(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 20,
                backgroundImage: currentUser.imageUrl != null 
                    ? NetworkImage(currentUser.imageUrl!) 
                    : null,
                backgroundColor: AppColors.cardBackground,
                child: currentUser.imageUrl == null 
                    ? Icon(
                        Icons.person,
                        color: AppColors.secondaryText,
                      )
                    : null,
              ),
              const SizedBox(width: AppSizes.spaceMD),
              
              // Your Library Title
              Expanded(
                child: Text(
                  'Your Library',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              // Search Icon
              IconButton(
                icon: const Icon(Icons.search),
                color: AppColors.primaryText,
                onPressed: () {
                  // Open library search
                },
              ),
              
              // More Options
              IconButton(
                icon: const Icon(Icons.add),
                color: AppColors.primaryText,
                onPressed: () {
                  // Show add menu (playlist, folder, etc.)
                },
              ),
            ],
          ),
        ),
        
        // Liked Songs Item
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding,
            vertical: AppSizes.spaceSM,
          ),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusXS),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF450AF5),
                  Color(0xFF8E2DE2),
                  Color(0xFFA663CC),
                  Color(0xFFBE93C5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            'Liked Songs',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '${likedSongs.length} songs',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          onTap: () {
            // Navigate to liked songs
          },
        ),
        
        // Downloaded Music (if any)
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding,
            vertical: AppSizes.spaceSM,
          ),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusXS),
              color: AppColors.spotifyGreen,
            ),
            child: const Icon(
              Icons.download,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            'Downloaded',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'None',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          onTap: () {
            // Navigate to downloaded music
          },
        ),
        
        const SizedBox(height: AppSizes.spaceMD),
      ],
    );
  }
}