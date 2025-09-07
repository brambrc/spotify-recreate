# Spotify Enhancement
<p align="center">
  <img src="https://github.com/user-attachments/assets/73ab60bf-72d1-489b-b4fa-de59cd125034" width="250" />
  <img src="https://github.com/user-attachments/assets/394d5df9-89d1-4a5f-9d33-042a0be634fa" width="250" />
  <img src="https://github.com/user-attachments/assets/a2c47cf5-0a5b-4c9d-8f7d-987ed7fe36b1" width="250" />
  <img src="https://github.com/user-attachments/assets/b0f232dd-4172-4e81-9b0f-aff7c08687a3" width="250" />
</p>


A comprehensive Flutter application that recreates and enhances the Spotify user interface with deep functionality and modular architecture.

## Features

### 🎵 Core Features
- **Authentic Spotify UI/UX**: Pixel-perfect recreation of Spotify's design language
- **Music Player**: Full-featured audio player with queue management
- **Search & Discovery**: Advanced search with filters and recommendations
- **Library Management**: Organize playlists, albums, and artists
- **User Authentication**: Secure login and profile management

### 🏗️ Architecture
- **Clean Architecture**: Separation of concerns with domain, data, and presentation layers
- **BLoC Pattern**: State management using flutter_bloc
- **Dependency Injection**: Injectable pattern with get_it
- **Modular Design**: Reusable components and widgets

### 🎨 UI/UX
- **Dark Theme**: Spotify's signature dark interface
- **Custom Components**: Tailored widgets for music apps
- **Responsive Design**: Optimized for various screen sizes
- **Smooth Animations**: Fluid transitions and interactions

## Tech Stack

- **Framework**: Flutter 3.24+
- **State Management**: BLoC (flutter_bloc)
- **Dependency Injection**: get_it + injectable
- **Navigation**: go_router
- **Audio**: just_audio + audio_service
- **Networking**: dio + retrofit
- **Local Storage**: hive + shared_preferences
- **UI Enhancements**: shimmer, lottie, cached_network_image

## Project Structure

```
lib/
├── core/
│   ├── constants/          # App-wide constants
│   ├── theme/             # Theme configuration
│   ├── router/            # Navigation setup
│   └── di/               # Dependency injection
├── domain/
│   └── models/           # Data models
├── data/
│   ├── repositories/     # Data repositories
│   └── services/         # API services
└── presentation/
    ├── screens/          # App screens
    ├── widgets/          # Reusable widgets
    └── blocs/           # State management
```

## Getting Started

### Prerequisites
- Flutter SDK (3.24 or higher)
- Dart SDK (3.4 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd spotify_enhancement
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Android NDK Configuration

If you encounter NDK version issues, add this to `android/app/build.gradle.kts`:

```kotlin
android {
    ndkVersion = "27.0.12077973"
    // ... other configurations
}
```

## Development Guidelines

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent formatting

### State Management
- Use BLoC pattern for complex state
- Keep BLoCs focused and single-purpose
- Use events and states appropriately

### Widget Design
- Create reusable, modular widgets
- Follow composition over inheritance
- Implement proper widget testing

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Spotify for the amazing design inspiration
- Flutter team for the excellent framework
- Open source community for the fantastic packages

---

**Note**: This is a educational/portfolio project and is not affiliated with Spotify Technology S.A.
