import 'package:flutter/material.dart';
import 'pages/snake_starter.dart';
import 'pages/flappy_starter.dart';
import 'pages/layout_starter.dart';
import 'pages/state_starter.dart';

/// Starter workshop app with a main menu and four starter pages.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Workshop Starter',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const WorkshopHomePage(),
        SnakeStarterPage.routeName: (context) => const SnakeStarterPage(),
        FlappyStarterPage.routeName: (context) => const FlappyStarterPage(),
        LayoutStarterPage.routeName: (context) => const LayoutStarterPage(),
        StateStarterPage.routeName: (context) => const StateStarterPage(),
      },
    );
  }
}

class WorkshopHomePage extends StatelessWidget {
  const WorkshopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workshop Home'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Choose a starter exercise below. Each page contains scaffolding, placeholders and short tips to help you implement the exercise.',
          ),
          const SizedBox(height: 12),
          ListTile(
            title: const Text('Beginner Snake'),
            subtitle: const Text('Grid-based snake game (starter scaffolding)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(SnakeStarterPage.routeName),
          ),
          const Divider(),
          ListTile(
            title: const Text('Beginner Flappy Bird'),
            subtitle: const Text('Simple physics: gravity, jump and pipes (starter scaffolding)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(FlappyStarterPage.routeName),
          ),
          const Divider(),
          ListTile(
            title: const Text('Layout (UI & responsive)'),
            subtitle: const Text('Practice Row / Column / Flexible / Expanded'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(LayoutStarterPage.routeName),
          ),
          const Divider(),
          ListTile(
            title: const Text('State Management (setState basics)'),
            subtitle: const Text('Learn setState and where to plug Provider later'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(StateStarterPage.routeName),
          ),
        ],
      ),
    );
  }
}