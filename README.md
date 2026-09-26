📰 Newsty

A modern, feature-rich news application built with Flutter. Newsty lets users browse the latest headlines by category, search for articles, bookmark stories to read later, and manage their profile — all wrapped in a clean, responsive UI.

✨ Features
Onboarding — Smooth first-launch experience introducing the app to new users.
Authentication — Sign up and log in flows powered by a dedicated AuthCubit, with secure token handling via a custom Dio interceptor.
Home Feed — Browse trending articles with category filtering, infinite/sliver-based lists, and image loading with shimmer placeholders.
Article Details — Read the full article in a dedicated detail view.
Search — Find articles quickly with a dedicated search experience.
Bookmarks — Save articles locally (via Hive) to read later, with graceful empty-state handling.
Profile — View and edit user information through an interactive bottom sheet, including profile picture selection.
🏗️ Architecture

Newsty follows a feature-first project structure, separating concerns into distinct layers:

lib/
├── core/
│   ├── constans/              # App-wide constants
│   ├── datasource/
│   │   ├── local_data/        # Local persistence (Hive-based repositories)
│   │   └── remote_data/       # Remote API clients, Dio configs & interceptors
│   ├── enums/                 # Shared enums
│   ├── extentions/            # Dart extension methods
│   ├── models/                # Shared data models
│   ├── repos/                 # Shared repository abstractions
│   ├── theme/                 # App theming (colors, text styles, etc.)
│   └── widgets/                # Reusable shared widgets
├── features/
│   ├── auth/                  # Login & registration (Cubit-driven)
│   ├── bookmark/               # Saved articles
│   ├── details/                # Article details view
│   ├── home/                   # Home feed & categories
│   ├── main/                   # Main navigation shell (e.g. bottom nav)
│   ├── onboarding/              # First-launch onboarding flow
│   ├── profile/                 # User profile & settings
│   ├── search/                  # Article search
│   └── splash/                  # Splash screen
├── hive_registrar.g.dart       # Generated Hive type adapters registrar
└── main.dart
State management: flutter_bloc (Cubit) for feature logic, with provider used in select areas.
Networking: Dio, with custom interceptors for authentication and API key injection.
Local storage: Hive CE for fast, lightweight on-device persistence (e.g. bookmarks, cached user data).
Equatable for value-based state comparisons across Cubits.
🛠️ Tech Stack
Category	Packages
State Management	flutter_bloc, provider, equatable
Networking	dio
Local Storage	hive_ce_flutter, shared_preferences
UI / UX	flutter_screenutil, smooth_page_indicator, shimmer, flutter_svg, cached_network_image
Media	image_picker
Utilities	country_picker
Code Generation	build_runner, hive_ce_generator
🚀 Getting Started
Prerequisites
Flutter SDK (see environment.sdk in pubspec.yaml for the required version)
A configured editor (Android Studio / VS Code) with the Flutter & Dart plugins
Installation
Clone the repository:
bash
git clone https://github.com/Abraamehab2005/Newsty.git
cd Newsty
Install dependencies:
bash
flutter pub get
Generate Hive adapters (required after cloning or after modifying Hive models):
bash
dart run build_runner build --delete-conflicting-outputs
Run the app:
bash
flutter run
🧪 Running Analysis & Tests
bash
flutter analyze
flutter test
📄 License

This project currently has no license specified. All rights reserved by the author unless stated otherwise.

👤 Author

Ebraam — @Abraamehab2005