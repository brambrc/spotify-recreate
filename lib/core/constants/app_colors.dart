import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Spotify Colors
  static const Color spotifyGreen = Color(0xFF1DB954);
  static const Color spotifyBlack = Color(0xFF191414);
  static const Color spotifyDarkGrey = Color(0xFF121212);
  static const Color spotifyGrey = Color(0xFF282828);
  static const Color spotifyLightGrey = Color(0xFF535353);
  static const Color spotifyWhite = Color(0xFFFFFFFF);

  // Background Colors
  static const Color primaryBackground = spotifyBlack;
  static const Color secondaryBackground = spotifyDarkGrey;
  static const Color cardBackground = spotifyGrey;
  static const Color bottomNavBackground = Color(0xFF0A0A0A);

  // Text Colors
  static const Color primaryText = spotifyWhite;
  static const Color secondaryText = Color(0xFFB3B3B3);
  static const Color tertiaryText = Color(0xFF888888);

  // Accent Colors
  static const Color accent = spotifyGreen;
  static const Color accentSecondary = Color(0xFF1ED760);
  static const Color error = Color(0xFFE22134);
  static const Color warning = Color(0xFFFFA500);
  static const Color success = spotifyGreen;

  // Gradient Colors
  static const List<Color> gradientPrimary = [
    Color(0xFF1DB954),
    Color(0xFF1ED760),
  ];

  static const List<Color> gradientDark = [
    Color(0xFF191414),
    Color(0xFF121212),
  ];

  static const List<Color> gradientCard = [
    Color(0xFF282828),
    Color(0xFF1A1A1A),
  ];

  // Playback Controls
  static const Color playButton = spotifyWhite;
  static const Color pauseButton = spotifyWhite;
  static const Color skipButton = spotifyLightGrey;
  static const Color shuffleButton = spotifyLightGrey;
  static const Color repeatButton = spotifyLightGrey;
  static const Color activeControl = spotifyGreen;

  // Progress Bar
  static const Color progressActive = spotifyWhite;
  static const Color progressInactive = spotifyLightGrey;
  static const Color progressThumb = spotifyWhite;

  // Special Colors
  static const Color liked = Color(0xFF1DB954);
  static const Color premium = Color(0xFFFFD700);
  static const Color live = Color(0xFFFF0000);
  static const Color explicit = Color(0xFF888888);
}

