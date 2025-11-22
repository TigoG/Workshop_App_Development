# Lab: Flutter workshop — pick a track and build

Overview

This hands‑on lab is organized as short, focused tracks. Participants choose ONE track and implement the core functionality starting from the starter project. Each track is scoped to be approachable in ~30 minutes. Use the solution project to recover or compare your implementation.

Learning objectives

- Run and explore a Flutter starter app.
- Implement a focused feature (game mechanics or responsive layout).
- Practice simple state updates with setState and optional local persistence.
- Debug and recover using the provided solution code.

Prerequisites

- Flutter SDK installed and available on PATH (verify with flutter doctor).
- Android Studio or VS Code with Flutter/Dart plugins installed.
- Android emulator or physical device available.
- Git and access to the workshop repository.

Quick start

1. Clone the repo and open the Workshop folder:
   git clone https://github.com/TigoG/Workshop_App_Development.git

2. Open the starter project and get packages:
   cd Workshop/starter
   flutter pub get

3. Run the starter app:
   flutter run

4. If you need to recover quickly, open the solution project:
   cd ../solution
   flutter pub get
   flutter run

Repository layout (important files)

- Starter main: [`starter/lib/main.dart`](starter/lib/main.dart:1)
- Solution main: [`solution/lib/main.dart`](solution/lib/main.dart:1)
- Track starters (inside starter/lib/pages):
  - [`starter/lib/pages/snake_starter.dart`](starter/lib/pages/snake_starter.dart:1)
  - [`starter/lib/pages/flappy_starter.dart`](starter/lib/pages/flappy_starter.dart:1)
  - [`starter/lib/pages/layout_starter.dart`](starter/lib/pages/layout_starter.dart:1)
  - [`starter/lib/pages/state_starter.dart`](starter/lib/pages/state_starter.dart:1)

Choose a track (pick ONE)

- Snake — implement movement, food spawning, collisions. Open [`starter/lib/pages/snake_starter.dart`](starter/lib/pages/snake_starter.dart:1).
- Flappy — implement gravity, tap‑to‑flap, pipes, scoring. Open [`starter/lib/pages/flappy_starter.dart`](starter/lib/pages/flappy_starter.dart:1).
- Layout — build a responsive UI using Rows/Columns/Expanded and MediaQuery. Open [`starter/lib/pages/layout_starter.dart`](starter/lib/pages/layout_starter.dart:1).
- States — implement toggles/favourites and local UI state. Open [`starter/lib/pages/state_starter.dart`](starter/lib/pages/state_starter.dart:1).

Session flow — first 30 minutes instructor presentation, remainder participants' work

- 0–30 min: Instructor presentation & demo — cover objectives, repo layout, how to run the starter, a short live demo of one example track, and where to find the solution for recovery: [`solution/lib/main.dart`](solution/lib/main.dart:1).
- 30–80 min: Participants: choose ONE track and work independently (complete core steps, then pick one stretch/polish). Instructor circulates to unblock devices, emulator issues, dependencies, and logic questions.
- 80–90 min: Wrap up — invite 1–3 short demos (30–60s each), collect commits/PRs or zipped submissions, and summarize next steps.

Instructor tip: Keep the presentation focused and short so participants can spend most of the workshop actively building. Provide a prebuilt APK (`flutter build apk --debug`) or open the solution project if many students need a quick recovery option.

Track core steps (copy‑paste friendly hints)

- Snake
  1. Find or implement a game loop (Timer / periodic tick) to step the snake.
  2. Update snake body positions on each tick and handle direction changes from user input.
  3. Spawn food randomly; detect head-food collisions, grow snake, increase score.
  4. Detect collisions with walls or self and show a restart overlay.
  Solution: [`solution/lib/pages/snake_solution.dart`](solution/lib/pages/snake_solution.dart:1)

- Flappy
  1. Add a vertical velocity and apply gravity each tick; call setState() to update the bird's Y position.
  2. On user tap, add an upward impulse to the velocity.
  3. Spawn pipes that move left; detect collisions with the bird and stop the game on collision.
  4. Increase score when the bird passes pipes; show game over and restart controls.
  Solution: [`solution/lib/pages/flappy_solution.dart`](solution/lib/pages/flappy_solution.dart:1)

- Layout
  1. Replace placeholders with responsive widgets (Row/Column/Expanded/Flexible).
  2. Use MediaQuery or LayoutBuilder to adjust the layout for narrow/wide screens.
  3. Test on different device sizes and orientations; fix overflows and spacing.
  Solution: [`solution/lib/pages/layout_solution.dart`](solution/lib/pages/layout_solution.dart:1)

- States
  1. Implement a simple in‑memory data model (list of items) and UI to toggle favorites.
  2. Use setState to update the UI; ensure state is preserved while the app runs.
  3. (Stretch) Persist favourites using shared_preferences and load them in initState.
  Solution: [`solution/lib/pages/state_solution.dart`](solution/lib/pages/state_solution.dart:1)

Stretch goals (pick one)

- Persist favourites with shared_preferences so they survive restarts.
- Add a Hero animation or small transition to the detail screen.
- Add undo for favourite removal or a favourites-only filter.
- Add basic widget tests for core logic.

Troubleshooting quick fixes

- Run flutter doctor to verify your environment.
- Run flutter clean && flutter pub get when dependency/build issues occur.
- If no device is available, start an emulator with flutter emulators --launch <emulatorId> or start AVD Manager in Android Studio (see [`Workshop/HOW_TO_RUN_ANDROID_STUDIO.md`](Workshop/HOW_TO_RUN_ANDROID_STUDIO.md:1)).
- For Gradle/JDK issues, use the embedded JDK in Android Studio or set JDK 11+ in settings.

Useful commands

- flutter doctor
- flutter devices
- flutter emulators --launch <emulatorId>
- flutter run
- flutter build apk --debug