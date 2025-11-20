Run the Flutter app with Android Studio (concise guide)

Quick checklist
- Android Studio installed (2020+), Flutter & Dart plugins installed
- Flutter SDK available (system install or workspace copy at [`flutter/bin/flutter.bat`](flutter/bin/flutter.bat:1))
- Android SDK and emulator images installed via SDK Manager
- An emulator created (AVD) or a physical device with USB debugging enabled

Open the project
1. File → Open and select the folder that contains the app's `pubspec.yaml` (e.g. [`starter/pubspec.yaml`](starter/pubspec.yaml:1) or [`solution/pubspec.yaml`](solution/pubspec.yaml:1)).
2. If Android Studio asks for the Flutter SDK path, point it to the folder that contains `bin` (for example the workspace copy at [`flutter`](flutter:1)).

Install plugins
- Settings → Plugins → Marketplace → install 'Flutter' (this installs 'Dart' automatically).
- Restart Android Studio if prompted.

Get dependencies
- Open the Terminal in Android Studio (View → Tool Windows → Terminal) or use the IDE 'Pub get' action.
- Run: flutter pub get

Create & start an emulator (AVD)
- Tools → AVD Manager → Create Virtual Device → choose a device and system image → Finish.
- Start the emulator by clicking the green play icon in AVD Manager.

Run the app
1. Select the target device from the device selector (running emulator or physical device).
2. Choose the Run configuration (Android Studio should auto-detect a Flutter run configuration). If not, create one and point the entrypoint to [`starter/lib/main.dart`](starter/lib/main.dart:1) or [`solution/lib/main.dart`](solution/lib/main.dart:1).
3. Click Run (green ▶) or press Shift+F10. The IDE will build, install, and launch the app on the selected device.

Hot reload & debug
- Use the lightning icon (Hot reload) in the toolbar or press 'r' in a terminal running `flutter run`.
- Use the Debug tool window to set breakpoints, inspect variables, and view logs.
- Use Logcat for platform logs.

Physical device steps
- Enable Developer options and USB debugging on the Android device.
- Connect with a USB cable and accept the debugging prompt on the device.
- Verify the device shows up with: flutter devices

Common fixes / troubleshooting
- "Flutter SDK not found": Settings → Languages & Frameworks → Flutter → set SDK path to the folder with `bin` (e.g. [`flutter/bin/flutter.bat`](flutter/bin/flutter.bat:1)).
- "No connected devices": Start an emulator in AVD Manager or connect a physical device.
- "Gradle / JDK errors": Use the embedded JDK or set a compatible JDK 11+ under File → Settings → Build, Execution, Deployment → Build Tools → Gradle.
- "License/SDK issues": run flutter doctor --android-licenses and accept fees.
- If builds fail: run flutter clean && flutter pub get, then rebuild.

Run from terminal (optional)
- From the project folder: flutter run
- Build an APK: flutter build apk --debug

Running the workshop apps
- Starter app: open [`starter/pubspec.yaml`](starter/pubspec.yaml:1) and run [`starter/lib/main.dart`](starter/lib/main.dart:1)
- Solution app: open [`solution/pubspec.yaml`](solution/pubspec.yaml:1) and run [`solution/lib/main.dart`](solution/lib/main.dart:1)

Quick recovery options for a classroom
- Keep a prebuilt debug APK (flutter build apk) to install via adb for students who can't build locally.
- Provide a Gitpod/Codespaces fallback for participants who cannot install the SDK.

Where to find files
- Starter code: [`starter/lib/main.dart`](starter/lib/main.dart:1)
- Solution code: [`solution/lib/main.dart`](solution/lib/main.dart:1)
- Full run instructions file (existing): [`RUN_ANDROID_STUDIO.md`](RUN_ANDROID_STUDIO.md:1)

End of guide.