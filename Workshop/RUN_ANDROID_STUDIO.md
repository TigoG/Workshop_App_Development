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


## 5. Flutter desktop (optional)

If you also want to build Flutter apps for desktop (Windows, macOS, Linux), you need platform-specific native toolchains in addition to the Android Studio setup above. Android Studio remains useful for the Android SDK, AVD Manager and Flutter/Dart plugins, but desktop builds require extra tools:

### Windows
- Install Microsoft Visual Studio 2022 (Community edition is fine).
  - Open the Visual Studio Installer → Workloads → select **Desktop development with C++**.
  - Ensure these components are installed: MSVC (C++ build tools, e.g. v143), the Windows 10/11 SDK, and **C++ CMake tools for Windows** (CMake support).
  - Note: Visual Studio Code is an editor and does *not* replace Visual Studio’s MSVC toolchain required for Windows desktop builds.
- Enable support and verify:
  - Run: `flutter config --enable-windows-desktop`
  - Verify: `flutter doctor`

### macOS
- Install Xcode (full Xcode from the App Store) and the command-line tools:
  - Run: `xcode-select --install`
- Enable support and verify:
  - Run: `flutter config --enable-macos-desktop`
  - Verify: `flutter doctor`
- Note: Distribution on macOS requires code signing and notarization; configure signing in Xcode when packaging.

### Linux
- Install native build dependencies (Ubuntu/Debian example):
  - sudo apt-get update
  - sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
- Enable support and verify:
  - Run: `flutter config --enable-linux-desktop`
  - Verify: `flutter doctor`
- For other distributions install the equivalent packages for your distro.

Common troubleshooting
- Always run `flutter doctor` after installing toolchains and follow any suggested fixes.
- If `flutter doctor` reports missing Visual Studio components on Windows, open Visual Studio Installer → Modify and add the required workload/components.
- Keep Android Studio installed for the Android SDK, emulator (AVD) and the Flutter/Dart plugins — Android Studio is still the recommended place to manage Android SDK/AVDs.

## Useful links
- Android Studio download: https://developer.android.com/studio
- Visual Studio Code download: https://code.visualstudio.com/