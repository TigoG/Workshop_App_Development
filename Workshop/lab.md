# Lab: Build the Flutter Workshop App (guided steps)

Overview

This lab guides participants through incremental tasks that extend the starter app into the solution app. The starter app is at [`starter/lib/main.dart`](starter/lib/main.dart:1). The final solution is in [`solution/lib/main.dart`](solution/lib/main.dart:1) once complete.

Objectives

- Run and explore the starter app.
- Implement pull-to-refresh and search/filtering.
- Persist favorites locally with shared_preferences.
- Add a small UI polish (search bar, improved list items).

Estimated duration

- Setup & run starter: 10 minutes
- Inspect code & starter behavior: 10 minutes
- Pull-to-refresh: 15 minutes
- Search/filter: 20 minutes
- Persist favorites (optional / stretch): 20 minutes
- Finish & test: 15 minutes

Prerequisites

- Flutter SDK installed and set up (run `flutter doctor`).
- VS Code or Android Studio (with Flutter plugins).
- Android emulator or physical device.
- Git and access to the workshop repo.

Quick start

1. Clone the repo and open the starter folder:

   git clone <your-repo-url>
   cd starter
   flutter pub get
   flutter run

2. Open [`starter/lib/main.dart`](starter/lib/main.dart:1) in your editor and read the code.

Step 0 — Explore the starter app

1. Run the app and verify it shows a list of posts fetched from https://jsonplaceholder.typicode.com/posts.
2. Notice the favourite toggle (heart icon) and the detail view when tapping an item.
3. Look at the Post model and the _fetchPosts function in [`starter/lib/main.dart`](starter/lib/main.dart:1).

Step 1 — Add pull-to-refresh

Goal: Allow users to pull down the list to refresh posts from the network.

a) Wrap the ListView.builder in a RefreshIndicator.

b) Implement an async _refreshPosts function that re-calls _fetchPosts and updates the UI. Example:

   // insert into _HomePageState
   Future<void> _refreshPosts() async {
     final newPosts = await _fetchPosts();
     setState(() {
       _postsFuture = Future.value(newPosts);
     });
   }

c) Replace the ListView builder return with:

   return RefreshIndicator(
     onRefresh: _refreshPosts,
     child: ListView.builder(...),
   );

d) Run the app and test pulling to refresh. If the network is slow, you'll see the loading indicator again.

Step 2 — Add search / filtering

Goal: Add a search box to filter posts by title.

a) Add a TextField in the AppBar or as a small widget above the ListView. Example (simple AppBar action approach):

   // add String _query = '' to the state

   // place a TextField above the list (or in a modal) and update _query via onChanged

b) When building list items, filter the posts list using:

   final filtered = posts.where((p) => p.title.contains(_query)).toList();

c) Use the filtered list in the ListView.builder instead of posts.

d) Test typing text and verify the list filters live.

Step 3 — Persist favorites with shared_preferences (optional / stretch)

Goal: Save favourite post IDs locally so they survive app restarts.

a) Add `shared_preferences` to `pubspec.yaml` in the `starter/` or `solution/` project:

   shared_preferences: ^2.1.0

b) In `_HomePageState`, load saved favourites in initState using SharedPreferences:

   final prefs = await SharedPreferences.getInstance();
   final favList = prefs.getStringList('favorites') ?? [];
   setState(() {
     _favorites = favList.map(int.parse).toSet();
   });

c) When toggling a favorite, write the updated set back to prefs:

   await prefs.setStringList('favorites', _favorites.map((i) => i.toString()).toList());

d) Note: `_favorites` above is declared as `Set<int>`; you may need to make it `late` or nullable during initialization.

Step 4 — UI polish & optional extras

Ideas for extra polish (pick one if time allows):

- Add `RefreshIndicator` (if you didn't in Step 1).
- Add a FloatingActionButton to scroll to top or toggle favorites-only view.
- Add a small detail page animation or Hero transition for title.
- Add pull-to-refresh + error handling with retry button.

Step 5 — Compare to the solution

1. After finishing, open [`solution/lib/main.dart`](solution/lib/main.dart:1) and compare your implementation with the provided solution.
2. Run the solution app to verify behaviour.

Submission

- Push your branch to the class repo or zip and submit as instructed by the workshop instructor.

Instructor notes

- If people get stuck on emulator setup, switch them to the solution APK or Gitpod.
- Use the solution branch to recover quickly if many participants break the starter.

Troubleshooting tips

- If network calls fail in emulator, check emulator internet or use a physical device.
- Run `flutter clean` and `flutter pub get` if packages behave strangely.
- If errors mention AndroidX or gradle, try updating the SDK/emulator or use a prebuilt APK to continue.

Solution notes

- The solution implements pull-to-refresh, search, and (optionally) persisted favourites.
- See [`solution/lib/main.dart`](solution/lib/main.dart:1) for the final code.

End of lab

Good luck — ask for help if you get stuck. Keep changes small and test often.