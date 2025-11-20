# Flutter Workshop Starter

Minimal starter app for the 90–120 minute Flutter workshop.

Features:
- Fetch posts from https://jsonplaceholder.typicode.com/posts
- Display titles in a ListView
- Toggle favorites (in-memory)
- Detail view for each post

Prerequisites
- Flutter SDK installed and added to PATH
- VS Code or Android Studio with Flutter & Dart plugins (recommended)
- An Android emulator or physical device (iOS requires macOS)
- Git (to clone the repo)

Quick start
1. Clone this repository:
   git clone <your-repo-url>
2. Change directory and run:
   cd starter
   flutter pub get
   flutter run

Project structure
- pubspec.yaml — project manifest
- lib/main.dart — main app code (starter UI & networking)

Where to edit
- See [`starter/lib/main.dart`](starter/lib/main.dart:1) for the main widgets, fetch logic, and TODO comments.

Common workshop tasks
- The `http` package is already added in `pubspec.yaml`.
- The `Post` model and `Post.fromJson` are implemented in `main.dart` for reference.

Troubleshooting
- Run `flutter doctor` to check the environment and follow the recommended fixes.
- If the emulator cannot start, try using a physical device or the Gitpod fallback.
- If networking calls fail, ensure your emulator/device has internet access and disable any blocking proxies.

Fallback options
- Provide a Gitpod or Codespaces configuration for browser-based development.
- Offer recorded demo videos or a prebuilt APK to follow along if installs fail.

Notes for instructors
- Keep edits small and incremental; run the app after each change.
- Keep a solution branch or zip ready for quick recovery during the workshop.

License
MIT