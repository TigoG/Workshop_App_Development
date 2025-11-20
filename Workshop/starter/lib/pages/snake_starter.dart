import 'package:flutter/material.dart';

/*
STARTER CODE - Snake
TIPS:
- Use a grid (List<List<int>> or List<Point<int>>) to represent cells.
- Represent the snake as a List<Point<int>> (head is first or last).
- Use a periodic Timer or AnimationController to advance the snake and call setState().
- Handle user input via swipe gestures or on-screen buttons.
- Keep game logic (movement, collisions, apple spawn) separated from UI.
*/

// This page is intentionally minimal: students will implement the actual game logic.
class SnakeStarterPage extends StatefulWidget {
  static const String routeName = '/snake';
  const SnakeStarterPage({super.key});

  @override
  State<SnakeStarterPage> createState() => _SnakeStarterPageState();
}

class _SnakeStarterPageState extends State<SnakeStarterPage> {
  // STARTER: game state placeholders
  // TODO: replace with actual grid size and snake positions.
  // Example:
  // final int rows = 20;
  // final int cols = 20;
  // List<Point<int>> snake = [Point(10,10), Point(10,11)];
  // Timer? gameTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beginner Snake (Starter)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create a simple grid-based Snake game. Implement the grid, snake movement, apple spawning and collision detection. This page provides scaffolding and tips only.',
            ),
            const SizedBox(height: 12),
            Container(
              height: 320,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Game area placeholder',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            const Text('STARTER CODE', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text(
              '// TODO: Define grid size and data structures (e.g. List<Point<int>> for the snake)\n'
              '// TODO: Add a Timer/AnimationController to step the game and call setState()\n'
              '// TODO: Implement controls (swipe gestures or buttons) to change direction\n'
              '// TODO: Detect collisions with walls and self, implement apple eating/scoring\n'
              '// TIP: Keep the game loop logic separate from UI - create a GameController class later.',
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Placeholder for start/reset action.
                // TODO: Wire this to your game controller to start/reset the game.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Starter action placeholder')),
                );
              },
              child: const Text('Start (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}