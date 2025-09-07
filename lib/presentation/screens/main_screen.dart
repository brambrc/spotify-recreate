import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/router/app_router.dart';
import '../blocs/player/player_bloc.dart';
import '../widgets/mini_player.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: child),
            BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                if (state is PlayerPlayingState || state is PlayerPausedState) {
                  return const MiniPlayer();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bottomNavBackground,
        border: Border(
          top: BorderSide(
            color: AppColors.spotifyLightGrey,
            width: 0.2,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding,
            vertical: 6.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: AppStrings.home,
                route: AppRouter.home,
                isActive: currentLocation == AppRouter.home,
              ),
              _buildNavItem(
                context,
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                label: AppStrings.search,
                route: AppRouter.search,
                isActive: currentLocation == AppRouter.search,
              ),
              _buildNavItem(
                context,
                icon: Icons.library_music_outlined,
                activeIcon: Icons.library_music,
                label: AppStrings.library,
                route: AppRouter.library,
                isActive: currentLocation == AppRouter.library,
              ),
              _buildNavItem(
                context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: AppStrings.profile,
                route: AppRouter.profile,
                isActive: currentLocation == AppRouter.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required String route,
    required bool isActive,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.go(route),
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive 
                  ? AppColors.spotifyGreen 
                  : AppColors.secondaryText,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isActive 
                    ? AppColors.spotifyGreen 
                    : AppColors.secondaryText,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

