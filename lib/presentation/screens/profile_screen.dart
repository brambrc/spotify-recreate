import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../blocs/auth/auth_bloc.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_stats.dart';
import '../widgets/profile_menu_list.dart';
import '../../data/services/mock_data_service.dart';
import '../../domain/models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.primaryText),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.primaryText),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: AppColors.primaryBackground,
        child: Column(
          children: [
            // Simple test content
            Container(
              height: 100,
              color: Colors.red,
              margin: const EdgeInsets.all(16),
              child: const Center(
                child: Text(
                  'PROFILE SCREEN TEST',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // User info
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile image
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Name
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Stats
                    const Text(
                      '25 following • 3 followers',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 16,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: AppColors.primaryText),
                          ),
                          child: const Text(
                            'Edit profile',
                            style: TextStyle(color: AppColors.primaryText),
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Simple content sections
                    Container(
                      height: 200,
                      color: Colors.blue.withOpacity(0.2),
                      child: const Center(
                        child: Text(
                          'Public Playlists Section',
                          style: TextStyle(color: AppColors.primaryText),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Container(
                      height: 200,
                      color: Colors.green.withOpacity(0.2),
                      child: const Center(
                        child: Text(
                          'Recently Played Section',
                          style: TextStyle(color: AppColors.primaryText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeaderSection extends StatelessWidget {
  final User user;
  
  const _ProfileHeaderSection({required this.user});

  @override
  Widget build(BuildContext context) {
    print('DEBUG: ProfileHeaderSection building with user: ${user.displayName}');
    return Container(
      padding: const EdgeInsets.all(AppSizes.horizontalPadding),
      color: Colors.blue.withOpacity(0.3), // Debug background
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Debug text
          Text(
            'DEBUG: Profile Header for ${user.displayName}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundImage: user.imageUrl != null 
                ? NetworkImage(user.imageUrl!) 
                : null,
            backgroundColor: AppColors.cardBackground,
            child: user.imageUrl == null 
                ? Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.secondaryText,
                  )
                : null,
          ),
          const SizedBox(height: AppSizes.spaceLG),
          
          // User Name
          Text(
            user.displayName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSizes.spaceSM),
          
          // Follower Count
          Text(
            '${user.followersString} followers • ${user.followingString} following',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.secondaryText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSizes.spaceMD),
          
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Follow Button (for other users)
              ElevatedButton(
                onPressed: () {
                  // Toggle follow status
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.primaryText,
                  side: BorderSide(color: AppColors.secondaryText),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceMD,
                    vertical: AppSizes.spaceSM,
                  ),
                ),
                child: const Text('Edit profile'),
              ),
              const SizedBox(width: AppSizes.spaceSM),
              
              // Options Button
              IconButton(
                onPressed: () {
                  // Show options menu
                },
                icon: const Icon(
                  Icons.more_horiz,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserPublicPlaylistsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mockDataService = MockDataService.instance;
    final userPlaylists = mockDataService.getUserPlaylists().where((playlist) => playlist.public).take(3).toList();

    if (userPlaylists.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Public playlists',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (userPlaylists.length >= 3)
                TextButton(
                  onPressed: () {
                    // Show all playlists
                  },
                  child: Text(
                    'Show all',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
            itemCount: userPlaylists.length,
            itemBuilder: (context, index) {
              final playlist = userPlaylists[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: AppSizes.spaceSM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                        color: AppColors.cardBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                        child: playlist.imageUrl != null
                            ? Image.network(
                                playlist.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.library_music,
                                    size: 40,
                                    color: AppColors.secondaryText,
                                  );
                                },
                              )
                            : Icon(
                                Icons.library_music,
                                size: 40,
                                color: AppColors.secondaryText,
                              ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceSM),
                    Text(
                      playlist.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${playlist.totalTracks} songs',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.spaceMD),
      ],
    );
  }
}

class _RecentlyPlayedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mockDataService = MockDataService.instance;
    final recentTracks = mockDataService.getRecentlyPlayedTracks().take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
          child: Text(
            'Recently played',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceMD),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
            itemCount: recentTracks.length,
            itemBuilder: (context, index) {
              final track = recentTracks[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: AppSizes.spaceSM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                        color: AppColors.cardBackground,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                        child: track.imageUrl != null
                            ? Image.network(
                                track.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.music_note,
                                    size: 40,
                                    color: AppColors.secondaryText,
                                  );
                                },
                              )
                            : Icon(
                                Icons.music_note,
                                size: 40,
                                color: AppColors.secondaryText,
                              ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceSM),
                    Text(
                      track.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      track.artistsString,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.spaceMD),
      ],
    );
  }
}

class _ArtistsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mockDataService = MockDataService.instance;
    final followedArtists = mockDataService.artists.where((artist) => artist.isFollowing).take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Following',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Show all artists
                },
                child: Text(
                  'Show all',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.spaceMD),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
            itemCount: followedArtists.length,
            itemBuilder: (context, index) {
              final artist = followedArtists[index];
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: AppSizes.spaceSM),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: artist.imageUrl != null 
                          ? NetworkImage(artist.imageUrl!) 
                          : null,
                      backgroundColor: AppColors.cardBackground,
                      child: artist.imageUrl == null 
                          ? Icon(
                              Icons.person,
                              size: 30,
                              color: AppColors.secondaryText,
                            )
                          : null,
                    ),
                    const SizedBox(height: AppSizes.spaceSM),
                    Text(
                      artist.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.spaceMD),
      ],
    );
  }
}

class _UnauthenticatedView extends StatelessWidget {
  const _UnauthenticatedView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sectionPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: AppSizes.iconXXL * 2,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSizes.spaceLG),
            Text(
              'Sign in to view your profile',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceMD),
            Text(
              'Access your playlists, saved music, and personalized recommendations',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceXL),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to login
                },
                child: const Text(AppStrings.login),
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to signup
                },
                child: const Text(AppStrings.signup),
              ),
            ),
          ],
        ),
      ),
    );
  }
}