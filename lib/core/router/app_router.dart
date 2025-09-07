import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/main_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/library_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/player_screen.dart';
import '../../presentation/screens/playlist_detail_screen.dart';
import '../../presentation/screens/album_detail_screen.dart';
import '../../presentation/screens/artist_detail_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String search = '/search';
  static const String library = '/library';
  static const String profile = '/profile';
  static const String player = '/player';
  static const String playlist = '/playlist';
  static const String album = '/album';
  static const String artist = '/artist';
  static const String login = '/login';
  static const String signup = '/signup';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      // Auth Routes
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signup,
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),

      // Main Shell Route with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: search,
            name: 'search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: library,
            name: 'library',
            builder: (context, state) => const LibraryScreen(),
          ),
          GoRoute(
            path: profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Full Screen Routes
      GoRoute(
        path: player,
        name: 'player',
        builder: (context, state) => const PlayerScreen(),
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PlayerScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
        ),
      ),

      // Detail Routes
      GoRoute(
        path: '$playlist/:id',
        name: 'playlist_detail',
        builder: (context, state) {
          final playlistId = state.pathParameters['id']!;
          return PlaylistDetailScreen(playlistId: playlistId);
        },
      ),
      GoRoute(
        path: '$album/:id',
        name: 'album_detail',
        builder: (context, state) {
          final albumId = state.pathParameters['id']!;
          return AlbumDetailScreen(albumId: albumId);
        },
      ),
      GoRoute(
        path: '$artist/:id',
        name: 'artist_detail',
        builder: (context, state) {
          final artistId = state.pathParameters['id']!;
          return ArtistDetailScreen(artistId: artistId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  const FadeTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
    transitionsBuilder: _fadeTransition,
  );

  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, _) => child,
      transitionsBuilder: transitionsBuilder!,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

class SlideTransitionPage extends CustomTransitionPage<void> {
  const SlideTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
    transitionsBuilder: _slideTransition,
  );

  static Widget _slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      )),
      child: child,
    );
  }

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, _) => child,
      transitionsBuilder: transitionsBuilder!,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
