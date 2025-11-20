Starter Kotlin — Experienced developers starter

Overview

This folder contains a minimal Android project written in Kotlin intended as a "starter" for more experienced participants.
It includes a simple Activity using ViewBinding and a small layout.

Structure

- starter_kotlin/ (project root)
- app/ (Android application module)
- app/src/main/kotlin/com/example/starter/MainActivity.kt
- app/src/main/res/layout/activity_main.xml
- app/src/main/res/values/strings.xml
- app/src/main/res/values/styles.xml
- app/build.gradle.kts
- settings.gradle.kts

Requirements

- Android Studio (recommended) or the Android Gradle toolchain
- JDK 17 (required by the project configuration)
- Android SDK with API 34

Quick start (Android Studio)

1. Open Android Studio -> Open an existing project -> select the folder [`starter_kotlin/`](starter_kotlin:1).
2. Allow Gradle to sync and download dependencies.
3. Start an emulator or connect a device.
4. Run the 'app' configuration (green Run) or choose Build -> Run.

Quick start (Command line)

- On Windows:
  - From the project root run: .\gradlew.bat assembleDebug
- On macOS/Linux:
  - From the project root run: ./gradlew assembleDebug

Notes

- View binding is enabled; see [`starter_kotlin/app/src/main/kotlin/com/example/starter/MainActivity.kt`](starter_kotlin/app/src/main/kotlin/com/example/starter/MainActivity.kt:1).
- The project targets compileSdk 34 and uses Kotlin 1.9.10.
- If you prefer a lightweight console Kotlin starter, ask and I can add one.

Contributing

Pull requests welcome — keep changes minimal so the starter remains easy to reset between workshop runs.

License

MIT