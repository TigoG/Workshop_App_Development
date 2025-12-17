# Create a new Flutter project

This document contains standalone instructions to create, run, and open a Flutter project. It's intended to be distributed separately (for others to download) or used as a workshop handout.

Prerequisites

- Android Studio installed: https://developer.android.com/studio
- For Android development, Android SDK and an emulator set up in Android Studio.
- Flutter SDK (optional): If you plan to create and run Flutter projects entirely from within Android Studio using the Flutter & Dart plugins, you do not need to manually install the Flutter SDK beforehand. The plugin can prompt to download or configure a local SDK during setup. However, if you want to use Flutter commands from the terminal (flutter create, flutter run, flutter pub get), you must install the Flutter SDK and add it to your PATH: https://flutter.dev/docs/get-started/install

Quick demo

- Create a demo project in a new directory:
  flutter create demo_app

- Run the demo:
  cd demo_app
  flutter pub get
  flutter run

- Or scaffold the demo in the current directory (directory must be empty):
  flutter create .

Create your own project

- Create in a new directory:
  flutter create my_app

After creating the project

1. Change into the project folder:
   cd my_app   (or stay if you used `flutter create .`)

2. Get dependencies:
   flutter pub get

3. Run on an attached device or emulator:
   flutter run

Opening the project in Android Studio
- Android Studio → File > Open and select the project's root folder.
- If prompted, install Flutter and Dart plugins.
- Select a device/emulator from the toolbar and press the Run (Play) button.

Notes and warnings

- `flutter create .` must be run in an empty directory. It may overwrite files if run in a non-empty directory.
- Make sure the Flutter SDK path is available in your PATH environment variable.
- If Android SDK tools or licenses are missing, run:

   flutter doctor
   flutter doctor --android-licenses
   and accept all licenses.

- If you get dependency errors, run:
   flutter pub get

Troubleshooting tips

- "SDK not found": Ensure ANDROID_SDK_ROOT or ANDROID_HOME environment variables point to the Android SDK location.
- "Device not found": Check USB debugging on a physical device and run `adb devices`.
- Emulator slow: enable virtualization in BIOS/UEFI and use x86 images; install Intel HAXM on Intel CPUs or use the Android Emulator Hypervisor (or prefer x86_64 images on Apple Silicon where supported).

Useful links

- Android Studio: https://developer.android.com/studio