import 'package:flutter/material.dart';

/*
STARTER CODE - State Management
TIPS:
- Use setState in a StatefulWidget to update local widget state.
- The example below shows a simple counter using setState().
- For app-wide/shared state use Provider/Riverpod: move the model/logic out of widgets into a ChangeNotifier or similar.
- Keep business logic separate from UI so widgets become easier to test and reuse.
*/

class StateStarterPage extends StatefulWidget {
  static const String routeName = '/state';
  const StateStarterPage({super.key});

  @override
  State<StateStarterPage> createState() => _StateStarterPageState();
}

class _StateStarterPageState extends State<StateStarterPage> {
  // Starter local state
  int _counter = 0;

  // TODO: Replace this simple counter with more realistic examples (toggles, forms, game state)
  // TODO: If multiple widgets need the same state, lift it up or switch to Provider (see TIP above).

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management (Starter)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Practice setState and where to move to Provider. The example below is a small interactive counter demonstrating local state updates.',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Counter example', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Value: $_counter', style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _increment,
                        icon: const Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: _reset,
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text('STARTER CODE', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text(
              '// TODO: Use setState to update UI when state changes\n'
              '// TODO: Lift state up or use Provider when multiple widgets need the same state\n'
              '// TODO: Extract business logic into ChangeNotifier or service classes when moving to Provider\n'
              '// TIP: Keep UI widgets dumb and move state/manipulation to controllers or models.',
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // TODO: Demonstrate a more complex state update or navigate to an example page.
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Placeholder action')));
              },
              child: const Text('More examples (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}