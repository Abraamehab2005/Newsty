# 📰 Newsty

A modern, feature-rich **news application built with Flutter**.

Newsty allows users to browse the latest headlines by category, search for articles, bookmark stories to read later, and manage their profile — all wrapped in a clean and responsive UI.

---

## ✨ Features

### 🔐 Authentication

* Sign up and login flows.
* Authentication managed using `AuthCubit`.
* Secure token handling.
* Custom `Dio Interceptor` for authentication.

### 🚀 Onboarding

* Smooth first-launch experience.
* Introduces new users to the application.

### 🏠 Home Feed

* Browse the latest and trending articles.
* Filter articles by category.
* Infinite scrolling using sliver-based lists.
* Shimmer placeholders while images are loading.

### 📰 Article Details

* Open an article from the feed.
* Read the full article in a dedicated details screen.

### 🔎 Search

* Search for articles quickly.
* Dedicated search experience.

### 🔖 Bookmarks

* Save articles to read later.
* Articles are stored locally using `Hive`.
* Handles empty bookmark states gracefully.

### 👤 Profile

* View user information.
* Edit profile information.
* Select and update profile picture.
* Interactive bottom sheet for profile editing.

---

## 🏗️ Architecture

Newsty follows a **Feature-First Architecture**, where each application feature is separated into its own module.

This keeps the project organized, scalable, and easier to maintain.

### 📁 Project Structure

```text
lib/
├── core/
│   ├── constants/
│   │   └── # App-wide constants
│   │
│   ├── datasource/
│   │   ├── local_data/
│   │   │   └── # Local persistence and Hive repositories
│   │   │
│   │   └── remote_data/
│   │       └── # Remote API clients, Dio configuration & interceptors
│   │
│   ├── enums/
│   │   └── # Shared enums
│   │
│   ├── extensions/
│   │   └── # Dart extension methods
│   │
│   ├── models/
│   │   └── # Shared data models
│   │
│   ├── repos/
│   │   └── # Shared repository abstractions
│   │
│   ├── theme/
│   │   └── # App colors, text styles and theme configuration
│   │
│   └── widgets/
│       └── # Reusable shared widgets
│
├── features/
│   ├── auth/
│   │   └── # Login & registration
│   │
│   ├── bookmark/
│   │   └── # Saved articles
│   │
│   ├── details/
│   │   └── # Article details
│   │
│   ├── home/
│   │   └── # Home feed & categories
│   │
│   ├── main/
│   │   └── # Main navigation shell
│   │
│   ├── onboarding/
│   │   └── # First-launch onboarding
│   │
│   ├── profile/
│   │   └── # User profile & settings
│   │
│   ├── search/
│   │   └── # Article search
│   │
│   └── splash/
│       └── # Splash screen
│
├── hive_registrar.g.dart
└── main.dart
```

---

## 🧠 State Management

The application mainly uses **Cubit** for state management.

### Packages

* `flutter_bloc`
* `provider`
* `equatable`

`Cubit` is used to separate UI from business logic and manage feature states in a clean and predictable way.

`Equatable` is used for value-based state comparison.

---

## 🌐 Networking

Newsty uses **Dio** for communicating with remote APIs.

A custom interceptor is used to handle common networking tasks such as:

* Authentication tokens.
* API key injection.
* Request configuration.
* Centralized network handling.

```text
Flutter App
     │
     ▼
    Dio
     │
     ▼
Interceptor
     │
     ├── Authentication Token
     ├── API Key
     └── Request Configuration
     │
     ▼
   Remote API
```

---

## 💾 Local Storage

The application uses local storage for data that needs to remain available on the device.

### Hive CE

Used for:

* Bookmarked articles.
* Cached user data.
* Local persistence.

### Shared Preferences

Used for lightweight key-value data such as application preferences and simple flags.

---

## 🛠️ Tech Stack

| Category             | Packages                                                 |
| -------------------- | -------------------------------------------------------- |
| **State Management** | `flutter_bloc`, `provider`, `equatable`                  |
| **Networking**       | `dio`                                                    |
| **Local Storage**    | `hive_ce_flutter`, `shared_preferences`                  |
| **UI / UX**          | `flutter_screenutil`, `smooth_page_indicator`, `shimmer` |
| **Images & Assets**  | `flutter_svg`, `cached_network_image`, `image_picker`    |
| **Utilities**        | `country_picker`                                         |
| **Code Generation**  | `build_runner`, `hive_ce_generator`                      |

---

## 🚀 Getting Started

### Prerequisites

Before running the project, make sure you have:

* Flutter SDK installed.
* Android Studio or VS Code.
* Flutter and Dart plugins installed.
* A configured Android emulator or physical device.

The required Flutter version can be found in:

```text
pubspec.yaml
```

under the project's SDK environment configuration.

---

## 📥 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Abraamehab2005/Newsty.git
```

### 2. Navigate to the Project

```bash
cd Newsty
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Generate Hive Adapters

Hive models require generated adapters.

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

You should run this command after cloning the project and whenever Hive models are modified.

### 5. Run the Application

```bash
flutter run
```

---

## 🧪 Analysis & Testing

### Run Flutter Analyzer

```bash
flutter analyze
```

### Run Tests

```bash
flutter test
```

---

## 📂 Main Features Structure

The main features are organized as follows:

| Feature      | Responsibility                      |
| ------------ | ----------------------------------- |
| `auth`       | Login and registration              |
| `bookmark`   | Save and manage bookmarked articles |
| `details`    | Display full article details        |
| `home`       | Display news feed and categories    |
| `main`       | Application navigation              |
| `onboarding` | First-launch user introduction      |
| `profile`    | User information and settings       |
| `search`     | Search for articles                 |
| `splash`     | Application startup screen          |

---

## 🔄 Application Flow

```text
Splash Screen
      │
      ▼
  Onboarding
      │
      ▼
 Authentication
      │
      ├── Login
      │
      └── Sign Up
      │
      ▼
   Main App
      │
      ├── Home
      │
      ├── Search
      │
      ├── Bookmarks
      │
      └── Profile
```

---

## 🔖 Bookmark Flow

```text
Article
   │
   ▼
Bookmark Button
   │
   ▼
Hive Local Storage
   │
   ▼
Bookmarks Screen
   │
   ▼
Read Article Later
```

---

## 📌 Project Highlights

* Feature-first Flutter architecture.
* Cubit-based state management.
* Dio networking with custom interceptors.
* Hive-based local persistence.
* Responsive UI.
* Shimmer loading states.
* Cached network images.
* Authentication flow.
* Search functionality.
* Bookmark functionality.
* Profile management.
* Code generation using `build_runner`.

---

## 📄 License

This project currently has no license specified.

All rights are reserved by the author unless otherwise stated.

---

## 👤 Author

**Ebraam**

GitHub: [@Abraamehab2005](https://github.com/Abraamehab2005)
