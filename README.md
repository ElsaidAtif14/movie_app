# Movies App 🍿🎥

Movies App is a Flutter-based movie browsing application that provides a seamless experience for discovering, browsing, and enjoying movies. The app offers a user-friendly interface to explore movie details, watch trailers, and manage personal watchlists. Built with modern Flutter architecture, it ensures smooth performance across Android and iOS platforms.

🚀 Features
🏠 Home screen with movies & categories
⭐ Suggested Movies section
🔍 Search functionality
📋 Watchlist management
Add / remove movies
❤️ Favorite movies management
🎥 Movie details with trailers
👤 User Profile management
🎨 Dark theme support
⏳ Proper loading & error handling
🧱 Architecture & Tech Stack
Framework: Flutter
Language: Dart

State Management: BLoC (Business Logic Component)
Networking: Dio
Local Storage: Shared Preferences
Dependency Injection: GetIt
UI: Material Design widgets
Animations: Lottie, Staggered Animations
Video Playback: YouTube Player
Image Caching: Cached Network Image

Clean separation of layers:

Presentation (Views & Cubits)
Domain (Repositories & Use Cases)
Data (Models & Data Sources)
📂 Project Structure
```
lib/
├── main.dart                 # App entry point
├── constants/                # App-wide constants and themes
├── core/                     # Core utilities, services, network, theme
│   ├── constants/
│   ├── exceptions/
│   ├── failures/
│   ├── helpers/
│   ├── network/
│   ├── services/
│   ├── theme/
│   ├── utils/
│   └── widgets/
└── features/                 # Feature-specific modules
    ├── movies/
    │   ├── models/
    │   ├── repositories/
    │   ├── views/
    │   └── view_models/
    ├── profile/
    ├── search/
    ├── splach/
    └── watchlist/
assets/
├── bottomNavIcon/            # Navigation icons
├── fonts/                    # Custom fonts
├── images/                   # Static images
├── lottie/                   # Lottie animations (splash, etc.)
android/                      # Android-specific code
ios/                          # iOS-specific code
web/                          # Web-specific code
```


## Acknowledgments

- Flutter team for the amazing framework
- MovieDB API for movie data
- Lottie for smooth animations
