import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../blocs/home/home_bloc.dart';
import '../widgets/greeting_header.dart';
import '../widgets/quick_access_grid.dart';
import '../widgets/section_header.dart';
import '../widgets/horizontal_playlist_list.dart';
import '../widgets/recently_played_list.dart';
import '../widgets/loading_shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const _LoadingView();
          } else if (state is HomeLoadedState) {
            return _LoadedView(state: state);
          } else if (state is HomeErrorState) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<HomeBloc>().add(HomeLoadDataEvent()),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              LoadingShimmer(height: 100), // Greeting header
              SizedBox(height: AppSizes.spaceLG),
              LoadingShimmer(height: 200), // Quick access grid
              SizedBox(height: AppSizes.spaceLG),
              LoadingShimmer(height: 180), // Recently played
              SizedBox(height: AppSizes.spaceLG),
              LoadingShimmer(height: 180), // Made for you
            ],
          ),
        ),
      ],
    );
  }
}

class _LoadedView extends StatelessWidget {
  final HomeLoadedState state;

  const _LoadedView({required this.state});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Custom App Bar with Greeting
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: AppColors.primaryBackground,
          elevation: 0,
          expandedHeight: 120,
          flexibleSpace: FlexibleSpaceBar(
            background: GreetingHeader(
              userName: state.user?.displayName ?? 'Music lover',
              userImage: state.user?.imageUrl,
            ),
          ),
        ),

        // Quick Access Grid
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding,
            ),
            child: QuickAccessGrid(
              playlists: state.recentPlaylists.take(6).toList(),
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: AppSizes.spaceLG),
        ),

        // Recently Played
        if (state.recentlyPlayed.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: SectionHeader(
              title: AppStrings.recentlyPlayed,
              onSeeAll: () {
                // Navigate to recently played screen
              },
            ),
          ),
          SliverToBoxAdapter(
            child: RecentlyPlayedList(tracks: state.recentlyPlayed),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.spaceLG),
          ),
        ],

        // Made for You
        if (state.madeForYouPlaylists.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: SectionHeader(
              title: AppStrings.madeForYou,
              onSeeAll: () {
                // Navigate to made for you screen
              },
            ),
          ),
          SliverToBoxAdapter(
            child: HorizontalPlaylistList(
              playlists: state.madeForYouPlaylists,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.spaceLG),
          ),
        ],

        // Recommended for Today
        if (state.recommendedPlaylists.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: SectionHeader(
              title: AppStrings.recommendedForToday,
              onSeeAll: () {
                // Navigate to recommendations screen
              },
            ),
          ),
          SliverToBoxAdapter(
            child: HorizontalPlaylistList(
              playlists: state.recommendedPlaylists,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.spaceLG),
          ),
        ],

        // Jump Back In
        if (state.jumpBackInItems.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: SectionHeader(
              title: AppStrings.jumpBackIn,
              onSeeAll: () {
                // Navigate to jump back in screen
              },
            ),
          ),
          SliverToBoxAdapter(
            child: HorizontalPlaylistList(
              playlists: state.jumpBackInItems,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.spaceLG),
          ),
        ],

        // Bottom padding for mini player
        const SliverToBoxAdapter(
          child: SizedBox(height: AppSizes.spaceXXL),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sectionPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppSizes.iconXXL,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSizes.spaceMD),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceLG),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
}

