Run the Flutter app with Android Studio (Windows 11)

Quick checklist
- Android Studio installed (2020+), Flutter & Dart plugins installed
- Flutter SDK available (system install or workspace copy at [`flutter/bin/flutter.bat`](flutter/bin/flutter.bat:1))
- Android SDK and emulator images installed via SDK Manager
- An emulator created (AVD) or a physical device with USB debugging enabled

Open the project in Android Studio
1. File → Open, choose the folder that contains the project's `pubspec.yaml` (e.g. the starter app at [`starter/pubspec.yaml`](starter/pubspec.yaml:1)).
2. Android Studio will detect a Flutter project. If it asks for the Flutter SDK path, point it to the SDK folder (for example the workspace copy at [`flutter`](flutter:1) — the plugin expects the parent folder that contains `bin`.)

Install Flutter & Dart plugins (if missing)
1. Settings → Plugins → Marketplace → search 'Flutter' and install (this installs Dart automatically).
2. Restart Android Studio if prompted.

Get dependencies
1. Open the terminal in Android Studio (View → Tool Windows → Terminal) or use the IDE 'Pub get' action.
2. Run: flutter pub get

Create and start an emulator (AVD)
1. Tools → AVD Manager.
2. Create Virtual Device → choose device (e.g. Pixel 4), pick a system image (API 30+), download if needed, Finish.
3. Start the emulator (click the green 'play' icon in AVD Manager).

Run the app
1. In the top toolbar choose your target device (the running emulator or a connected physical device).
2. Select the run configuration (should detect the main Dart entrypoint; if not, create a new Flutter configuration pointing to `lib/main.dart` — for the starter app see [`starter/lib/main.dart`](starter/lib/main.dart:1)).
3. Click the green Run (play) button or press Shift+F10. The app will build and install on the device.

Use logcat and debug tools
- Open Logcat (bottom tool window) for Android logs. Use the Debug tool window to inspect variables and hot reload.
- Press 'Hot reload' (lightning icon) or press 'r' in the terminal running `flutter run` to apply code changes quickly.

Physical device steps
1. Enable Developer options and USB debugging on your Android device.
2. Connect via USB and accept the dialog on the device.
3. Run `flutter devices` in the terminal to confirm the device shows up.
4. Select the device in Android Studio and press Run.

Useful commands (Android Studio terminal or system terminal)
- flutter doctor
- flutter devices
- flutter emulators --launch <emulatorId>
- flutter run
- flutter clean && flutter pub get

If you see 'Gradle sync' or build errors
- Run `flutter pub get` and `flutter clean`.
- Open 'File → Sync Project with Gradle Files' and accept any SDK/Gradle updates.
- Ensure Android SDK Build-Tools and Platform are installed (Settings → Appearance & Behavior → System Settings → Android SDK).
- If you see license errors run `flutter doctor --android-licenses` and accept.

Running the solution app
- To run the final app (with persistent favorites), open the solution project root that contains [`solution/pubspec.yaml`](solution/pubspec.yaml:1) and point the run configuration to [`solution/lib/main.dart`](solution/lib/main.dart:1).

Troubleshooting tips
- If Android Studio prompts for a Gradle JDK, use the embedded JDK or a compatible JDK 11+.
- If emulator is slow, enable hardware acceleration (HAXM / Hyper-V / Windows Hypervisor).
- If networking calls fail on emulator, check emulator's internet and firewall/proxy settings.
- Use the solution APK (build with `flutter build apk --debug`) to install directly if the IDE build fails.

Where to find starter files
- Starter code: [`starter/lib/main.dart`](starter/lib/main.dart:1)
- Starter README: [`starter/README.md`](starter/README.md:1)
- Solution code: [`solution/lib/main.dart`](solution/lib/main.dart:1)

Common issues & fixes quick list
1) Flutter binary not found in Android Studio plugin: set Flutter SDK path to the folder that contains `bin` (e.g. [`flutter/bin/flutter.bat`](flutter/bin/flutter.bat:1)).
2) 'No connected devices' — start an emulator from AVD Manager or connect a physical device and run `flutter devices`.
3) 'Execution failed for task :app:installDebug' — uninstall the previous app from device or run `adb uninstall <package>` and retry.

That's it — follow these steps to run the app with Android Studio.