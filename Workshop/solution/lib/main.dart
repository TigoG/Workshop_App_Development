import 'package:flutter/material.dart';
import 'package:flutter_workshop_solution/pages/flappy_solution.dart';
import 'package:flutter_workshop_solution/pages/layout_solution.dart';
import 'package:flutter_workshop_solution/pages/snake_solution.dart';
import 'package:flutter_workshop_solution/pages/state_solution.dart';

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
        SnakeSolutionPage.routeName: (context) => const SnakeSolutionPage(),
        FlappySolutionPage.routeName: (context) => const FlappySolutionPage(),
        LayoutSolutionPage.routeName: (context) => const LayoutSolutionPage(),
        StateSolutionPage.routeName: (context) => const StateSolutionPage(),
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
            onTap: () => Navigator.of(context).pushNamed(SnakeSolutionPage.routeName),
          ),
          const Divider(),
          ListTile(
            title: const Text('Beginner Flappy Bird'),
            subtitle: const Text('Simple physics: gravity, jump and pipes (starter scaffolding)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(FlappySolutionPage.routeName),
          ),
          const Divider(),
          ListTile(
            title: const Text('Layout (UI & responsive)'),
            subtitle: const Text('Practice Row / Column / Flexible / Expanded'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(LayoutSolutionPage.routeName),
          ),
          const Divider(),
          ListTile(
            title: const Text('State Management (setState basics)'),
            subtitle: const Text('Learn setState and where to plug Provider later'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(StateSolutionPage.routeName),
          ),
        ],
      ),
    );
  }
}