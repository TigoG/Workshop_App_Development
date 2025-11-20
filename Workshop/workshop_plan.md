# Workshop: Mobile App Development with Flutter (1.5–2 hours)

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

## Detailed agenda (two timing options)
### 90‑minute (1.5 hr) agenda — recommended
- 00:00–00:10 (10 min): Welcome, objectives, quick environment check.
- 00:10–00:25 (15 min): Starter app walkthrough & run the app on devices/emulator.
- 00:25–00:50 (25 min): Live demo: build UI, explain StatefulWidget, add simple interactivity.
- 00:50–01:20 (30 min): Guided hands‑on lab: fetch and display data from a public API.
- 01:20–01:30 (10 min): Wrap‑up, next steps, resources, and feedback link.

### 120‑minute (2 hr) agenda — expanded
- 00:00–00:10 (10 min): Welcome, objectives, environment check.
- 00:10–00:25 (15 min): Starter app walkthrough & run the app.
- 00:25–00:45 (20 min): Live demo: UI + stateful interactions.
- 00:45–01:10 (25 min): Add HTTP fetch & display (demo + guided edits).
- 01:10–01:40 (30 min): Hands‑on lab: extend the app (e.g., add a detail view or favourite).
- 01:40–02:00 (20 min): Wrap‑up, Q&A, resources, feedback.

## Hands‑on lab (90‑min core)
Lab goal: Starting from a starter repo, implement a simple app that fetches a list of items from a public JSON API and displays them in a ListView. Add a simple local “favourite” toggle per item (held in memory).

Core lab steps (high level):
1. Clone starter repo and run `flutter pub get` and `flutter run`.
2. Inspect `lib/main.dart` and run the existing starter UI.
3. Add the `http` package to `pubspec.yaml`.
4. Create a simple data model and write an async function to fetch JSON from https://jsonplaceholder.typicode.com/posts.
5. Use a `FutureBuilder` to show a loading state, then a `ListView` of titles.
6. Add a simple in‑memory favourites set and a `setState` toggle to mark favourites.
7. Optional: implement tap → detail screen using `Navigator.push`.

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
Title: Workshop — Mobile App Development with Flutter (90–120 min)
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