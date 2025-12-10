# Run Android Studio
This page explains how to download, install, and run Android Studio and set up an Android emulator so you can run Android apps locally.

## 1. Download Android Studio
- Download the official Android Studio installer from: https://developer.android.com/studio
- Choose the correct installer for your operating system (Windows, macOS, Linux).

## 2. Install Android Studio

You can install Android Studio on Windows, macOS, or Linux. Follow the steps for your operating system below.

### Windows
1. Run the downloaded installer and follow the setup wizard.
2. When prompted, ensure the following components are selected:
   - Android Studio IDE
   - Android SDK
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
3. Choose the installation path (the default is fine).
4. Finish the installation and launch Android Studio.

### macOS
1. Open the downloaded .dmg file and drag Android Studio to the Applications folder.
2. Open Android Studio from Applications. If macOS blocks opening the app, Control-click the app and choose "Open", then confirm.
3. On first launch follow the setup wizard and install the Android SDK and recommended components. If you have an Apple Silicon (M1/M2) Mac, choose the Apple Silicon (arm64) build when available.
4. Complete the setup and launch the IDE.

### Linux
Option A — Snap (recommended on distributions that support Snap):

1. Install Android Studio with:
   sudo snap install android-studio --classic

Option B — Manual install:

1. Extract the downloaded .tar.gz to a directory such as /opt:
   sudo tar -xzf android-studio-*.tar.gz -C /opt
2. Run the studio launcher:
   /opt/android-studio/bin/studio.sh
3. Optionally create a desktop entry when prompted.

4. When prompted during the first run, install the Android SDK, Android SDK Platform-Tools, and Android SDK Build-Tools.

Note for Linux: The Android emulator requires certain 32-bit compatibility libraries on 64-bit systems. On Debian/Ubuntu these typically include:
   sudo apt-get install libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386

## 3. Install Flutter & Dart plugins (if using Flutter)
1. In Android Studio go to File > Settings (Android Studio > Preferences on macOS) > Plugins.
2. Search for and install "Flutter". Accept the prompt to also install the "Dart" plugin.
3. Restart Android Studio when prompted.

## 4. Configure the Android SDK
1. In Android Studio go to Configure > SDK Manager (or File > Settings > Appearance & Behavior > System Settings > Android SDK).
2. Install a recommended Android API level (for example, Android 15 / API level 35).
3. Under the SDK Tools tab ensure "Android SDK Platform-Tools" and "Android SDK Build-Tools" are installed.
4. Note the Android SDK location shown at the top; common default on Windows is: C:\Users\<your-username>\AppData\Local\Android\Sdk

## 5. Create and run an Android Virtual Device (AVD)
1. In Android Studio open Configure > AVD Manager (or Tools > AVD Manager).
2. Click "Create Virtual Device", choose a device profile, then select a system image (prefer an x86/x86_64 image with Google APIs).
3. Finish the wizard and then click the green 'Play' button to launch the emulator.

Thats enough for now, we will go through the rest in the workshop.

### Extra: Create a new Flutter project (Flutter only)?
If you're using Flutter, you can quickly scaffold a new app using the Flutter CLI.

- Create a new project in a new directory:
  flutter create my_app

- Create a Flutter project in the current directory (the directory must be empty):
  flutter create .

After creating the project:

1. Change into the project directory:
   cd my_app   (or stay in the current directory if you used `flutter create .`)
2. Get dependencies:
   flutter pub get
3. Run on an attached device or emulator:
   flutter run

To open the project in Android Studio:

- Open Android Studio → File > Open and select the project's root folder.
- Android Studio will detect the Flutter project. If prompted to install plugins or SDK components, follow the prompts.

Notes:

- `flutter create .` should be run in an empty directory — it will add project files and may overwrite existing files in a non-empty directory.
- If you see errors running `flutter create`, ensure the Flutter SDK is on your PATH and run `flutter doctor` to fix any issues.

## 6. Verify installation and accept licenses
1. Open a terminal (Command Prompt or PowerShell on Windows).
2. Run:
   flutter doctor
3. If you see Android tool or SDK license issues, run:
   flutter doctor --android-licenses
   and accept all licenses.

## 7. Run your app on an emulator or device
- To run from Android Studio: open your project, select a device/emulator in the toolbar, then click the Run (Play) button.
- From the terminal in your project folder (for Flutter projects) run:
   flutter run
- If running a native Android project from the command line, use Gradle:
   ./gradlew assembleDebug

## 8. Common troubleshooting
- Emulator is slow: enable hardware acceleration (Intel HAXM on Intel CPUs) or use an x86 image; ensure virtualization is enabled in BIOS/UEFI.
- SDK not found: ensure ANDROID_HOME or ANDROID_SDK_ROOT environment variables point to the SDK location if tools cannot locate it.
- Missing licenses: run flutter doctor --android-licenses and accept them.

## Useful links
- Android Studio download: https://developer.android.com/studio