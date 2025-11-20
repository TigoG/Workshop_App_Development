# ProGuard rules for starter_kotlin app
# Keep the main activity and generated view binding classes
-keep class com.example.starter.MainActivity { *; }
-keep class com.example.starter.databinding.** { *; }

# Keep Kotlin metadata and avoid warnings for Kotlin stdlib
-keepclassmembers class kotlin.Metadata { *; }
-dontwarn kotlin.**