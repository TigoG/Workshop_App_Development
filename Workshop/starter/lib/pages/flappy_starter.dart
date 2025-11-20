import 'package:flutter/material.dart';

/*
STARTER CODE - Flappy
TIPS:
- Represent player as vertical position and velocity (double y, vy).
- Use gravity (vy += gravity * dt) and jump impulse (vy = -jump).
- Use a periodic Timer or AnimationController/Ticker to update physics and call setState().
- Represent pipes as a list of x positions with gap positions; move them left each tick.
- Detect collisions between player rect and pipes/ground using simple bounding boxes.
- Keep physics and pipe generation logic separated from the UI.
*/

// Minimal placeholder scaffolding.
class FlappyStarterPage extends StatefulWidget {
  static const String routeName = '/flappy';
  const FlappyStarterPage({super.key});

  @override
  State<FlappyStarterPage> createState() => _FlappyStarterPageState();
}

class _FlappyStarterPageState extends State<FlappyStarterPage> {
  // STARTER: physics placeholders
  // TODO: Add double playerY, playerVelocity, gravity, jumpImpulse
  // TODO: Add list of pipe objects with x position and gapY
  // TODO: Use a TickerProviderStateMixin or Timer.periodic to step the simulation
  // TODO: On tap or button, apply jump impulse and call setState()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beginner Flappy Bird (Starter)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Implement a simple Flappy-like game. The player has vertical position and velocity; pipes move left. '
              'This page provides scaffolding and concise tips only.',
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // TODO: trigger jump (apply impulse to playerVelocity and call setState)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Jump (placeholder)')),
                );
              },
              child: Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Game area placeholder\n(tap to jump)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('STARTER CODE', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text(
              '// TODO: Define playerY and playerVelocity (double)\n'
              '// TODO: Use gravity and jump impulse; step simulation with Timer or Ticker\n'
              '// TODO: Generate pipes off-screen and move them left; recycle when off-screen\n'
              '// TODO: Detect collisions and reset game on crash\n'
              '// TIP: Use simple bounding boxes for collision detection; start with one pipe pair first.',
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Placeholder start/reset action.
                // TODO: Wire this to your game controller to start/reset the game.
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Start (placeholder)')));
              },
              child: const Text('Start (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}