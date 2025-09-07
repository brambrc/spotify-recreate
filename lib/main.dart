import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';
import 'presentation/blocs/player/player_bloc.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/home/home_bloc.dart';
import 'presentation/blocs/search/search_bloc.dart';
import 'presentation/blocs/library/library_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Configure dependency injection
  await configureDependencies();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.bottomNavBackground,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const SpotifyEnhancementApp());
}

class SpotifyEnhancementApp extends StatelessWidget {
  const SpotifyEnhancementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>()..add(AuthCheckStatusEvent()),
        ),
        BlocProvider<PlayerBloc>(
          create: (context) => getIt<PlayerBloc>(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>()..add(HomeLoadDataEvent()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => getIt<SearchBloc>()..add(SearchLoadGenresEvent()),
        ),
        BlocProvider<LibraryBloc>(
          create: (context) => getIt<LibraryBloc>()..add(LibraryLoadDataEvent()),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0, // Prevent text scaling
            ),
            child: child!,
          );
        },
      ),
    );
  }
}

class GlobalErrorHandler extends StatelessWidget {
  final Widget child;
  
  const GlobalErrorHandler({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}