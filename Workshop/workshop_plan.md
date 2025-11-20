# Workshop: Mobile App Development with Flutter (90 minutes)

## Overview
This workshop gives participants a practical introduction to mobile app development using Flutter. Primary focus is on hands‑on development: building a simple single‑screen app, connecting to a public API, and understanding widget structure and basic state management.

## Target audience
4th‑year HBO students (primarily Computer Engineering and Technical Engineering). Mostly experienced developers.

## Learning objectives
- Understand the Flutter development workflow and project structure.
- Build a simple responsive UI using widgets and layout (StatelessWidget vs StatefulWidget).
- Perform an asynchronous HTTP request and display results in a ListView.
- Add simple local state (e.g., favourites) and handle user interaction.
- Know where to go next: packages, state management patterns, testing, and publishing.

## Alternatives (brief mentions)
Mention other cross‑platform/native approaches during the intro (1 slide): React Native, Ionic/Capacitor, Kotlin Multiplatform, native Android (Kotlin) / iOS (SwiftUI) — briefly compare pros/cons and when Flutter is a good fit.

## Prerequisites & pre‑work (ask participants to complete before the session)
- Install Flutter SDK and add to PATH; verify with `flutter doctor`.
- Install Visual Studio Code (or Android Studio) and the Flutter/Dart extensions.
- Have an Android emulator or a physical device ready (iOS device requires a Mac).
- Git and a GitHub account (to clone the starter repo).
- Optional: ensure Node/npm is installed if using Gitpod or other tooling.

If some participants cannot install Flutter, provide fallback options (see Fallback section).

## Format & teaching methods
- Short intro (slides) to set expectations and objectives.
- Live demo: open the starter app, walk through main.dart and run the app.
- Guided hands‑on lab (pair up participants if needed).
- Short Q&A and pointers to follow‑up resources.

## Detailed agenda (90‑minute agenda)
- 00:00–00:10 (10 min): Welcome, objectives, quick environment check.
- 00:10–00:25 (15 min): Starter app walkthrough & run the app on devices/emulator.
- 00:25–00:50 (25 min): Live demo: build UI, explain StatefulWidget, add simple interactivity.
- 00:50–01:20 (30 min): Guided hands‑on lab: participants choose one of four lab tracks (Snake, Flappy Bird, Layout, States) and work on the selected starter.
- 01:20–01:30 (10 min): Wrap‑up, next steps, resources, and feedback link.

## Hands‑on lab (90‑min core)
Lab goal: Participants choose ONE of four lab tracks — Snake, Flappy Bird, Layout, or States — and implement the core features of that track starting from the starter repo. Each track is scoped to be approachable within the 30‑minute lab window.

Tracks (pick one)
- Snake (game)
  - Goal: implement snake movement, food spawning, collision detection and scoring.
  - Starter: [`Workshop/starter/lib/pages/snake_starter.dart`](Workshop/starter/lib/pages/snake_starter.dart:1)
  - Solution: [`Workshop/solution/lib/pages/snake_solution.dart`](Workshop/solution/lib/pages/snake_solution.dart:1)
  - Core steps:
    1. Run the starter and locate the snake scaffold.
    2. Implement the snake model and movement controls.
    3. Add food spawning and collision detection.
    4. Display score and restart on game over.

- Flappy Bird (game)
  - Goal: implement gravity, tap‑to‑flap, pipes and scoring.
  - Starter: [`Workshop/starter/lib/pages/flappy_starter.dart`](Workshop/starter/lib/pages/flappy_starter.dart:1)
  - Solution: [`Workshop/solution/lib/pages/flappy_solution.dart`](Workshop/solution/lib/pages/flappy_solution.dart:1)
  - Core steps:
    1. Run the starter and find the flappy scaffold.
    2. Add gravity and flap on tap.
    3. Spawn pipes and detect collisions.
    4. Track and display score.

- Layout (UI)
  - Goal: build a responsive screen using Rows/Columns/Flex/Expanded and MediaQuery.
  - Starter: [`Workshop/starter/lib/pages/layout_starter.dart`](Workshop/starter/lib/pages/layout_starter.dart:1)
  - Solution: [`Workshop/solution/lib/pages/layout_solution.dart`](Workshop/solution/lib/pages/layout_solution.dart:1)
  - Core steps:
    1. Open the starter and inspect the layout scaffold.
    2. Implement responsive widgets using Expanded/Flexible and MediaQuery.
    3. Ensure layout adapts to narrow/wide widths and orientation changes.

- States (state management basics)
  - Goal: implement local state (`setState`), toggles/favourites and simple UI updates.
  - Starter: [`Workshop/starter/lib/pages/state_starter.dart`](Workshop/starter/lib/pages/state_starter.dart:1)
  - Solution: [`Workshop/solution/lib/pages/state_solution.dart`](Workshop/solution/lib/pages/state_solution.dart:1)
  - Core steps:
    1. Run the starter and find the state scaffold.
    2. Add an in‑memory data model and toggle controls.
    3. Use `setState` to update the UI and reflect favourites.

General core lab steps:
1. Clone the starter repo and run `flutter pub get` and `flutter run`.
2. Inspect [`Workshop/starter/lib/main.dart`](Workshop/starter/lib/main.dart:1) to see how pages are wired and how to run each track.
3. Choose a track and follow the track's core steps above.
4. Optional: implement small extensions (detail screens, persistent storage, polish).

Instructor tips:
- Keep code small and incremental; show one change, run, then proceed.
- Prepare short clips for the most error‑prone steps (package install, emulator issues).
- Have the final solution ready in the repo for quick recovery.

## Materials to prepare
- Slides (intro + objectives + architecture + alternatives + resources).
- Starter repository (starter/) with runnable minimal app and clear TODO comments.
- Solution repository (solution/) with final code.
- Step‑by‑step lab instructions (lab.md) with copy‑paste snippets for key steps.
- Cheat sheet (flutter‑cheatsheet.pdf) with commands and common fixes.
- Pre‑recorded short videos for troubleshooting (emulator setup, flutter doctor).

Example starter repo structure:
```text
starter/
├─ README.md
├─ pubspec.yaml
└─ lib/
   └─ main.dart
```

## Fallback options (important for the installs failing)
- Provide a Gitpod or Codespaces config so participants can run the project in the browser without local installs.
- Provide recorded demos and the solution app APK for Android so attendees can follow along.
- Use DartPad for very small Flutter examples (note: networking is limited in DartPad).

## Teacher approval: one‑page proposal
Title: Workshop — Mobile App Development with Flutter (90 min)
Objectives: [list the learning objectives]
Audience: 4th‑year HBO students (Computer & Technical Engineering), mixed experience.
Format: Live demo + guided hands‑on lab + Q&A. Require students to install Flutter before the session; provide Gitpod fallback.
Date/Time: [proposed]
Required resources: Room with projector, internet, participants’ laptops, emulators or devices.
Assessment: short post‑workshop feedback + small code submission (optional).
Approval signature: _____________________

## Finding an external expert — outreach template
Hello [Name],
I'm organizing a 90–120 minute workshop on mobile app development with Flutter for 4th‑year HBO students. I would value your help to review the materials and be present during the session to assist participants. The session focuses on building a small app and connecting it to a public API.
Would you be available to (a) review the slide deck and lab instructions, and (b) attend the workshop on [date]? Compensation: [TBD] or thanks in credits.
Best, [Your name]

## Pilot & rehearsal checklist
- Run the full workshop at least once with 2–3 peers.
- Time each section and record where you go over/under time.
- Collect feedback via a short form (3 questions: clarity, pacing, usefulness).
- Fix any unclear lab steps and prepare additional troubleshooting notes.

## Day‑of technical checklist
- Projector & audio, stable internet.
- Instructor machine with Flutter installed (tested).
- Starter repo accessible (GitHub).

## Evaluation & follow‑up
- Short post‑workshop survey (1–5 rating + 1 free text).
- Share slide deck, starter & solution repo, cheat sheet and recorded clips.
- Suggest next steps: advanced Flutter state management (Provider/Bloc), testing, Firebase integration, publishing to stores.

## Example assessment questions (pre/post)
- Have you installed Flutter and run a starter app? (Y/N)
- Rate your confidence building a simple UI (1–5).
- Can you explain the difference between StatelessWidget and StatefulWidget? (short answer)

## Appendix: Quick run script (for instructors)
1. Clone the starter repo.
2. cd starter
3. flutter pub get
4. flutter run

## Notes on mentioning alternatives in the workshop
- Spend 2–3 minutes on curated comparisons: where cross‑platform fits, native tradeoffs, and teams’ strengths.

## Final remarks
- Keep the session practical and low‑friction: prefer small, visible changes that run quickly.
- Provide clear recovery steps when something fails; keep the solution repo ready to show the final result.
- After the workshop, gather feedback and publish a short "what went well / what to improve" list.