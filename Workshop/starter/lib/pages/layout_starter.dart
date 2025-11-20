import 'package:flutter/material.dart';

/*
STARTER CODE - Layout
TIPS:
- Use Column and Row for vertical/horizontal layouts.
- Use Expanded / Flexible to allocate available space: Expanded(child: ...) fills remaining space; Flexible lets a child be flexible with a given flex.
- Use LayoutBuilder or MediaQuery to inspect available width and switch between single-column and multi-column layouts (e.g. two-column for tablets).
- Use Wrap for flows of chips or responsive lists.
- Keep widgets small and extract repeating patterns into separate widgets for readability and testing.
*/

class LayoutStarterPage extends StatelessWidget {
  static const String routeName = '/layout';
  const LayoutStarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout (Starter)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Practice building responsive UIs. Replace the placeholder below with Rows, Columns, Flexible/Expanded and try LayoutBuilder or MediaQuery to adapt to screen sizes.',
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isWide
                        ? 'Wide layout preview placeholder'
                        : 'Narrow layout preview placeholder',
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            const Text('STARTER CODE', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text(
              '// TODO: Replace the preview with a responsive layout using LayoutBuilder or MediaQuery\n'
              '// TODO: Use Row/Column + Expanded/Flexible to create adaptive layouts\n'
              '// TODO: Try switching between single-column and two-column layouts for wide screens\n'
              '// TIP: Keep widgets small and extract repeating patterns into their own widgets\n',
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // TODO: Provide a simple example action or navigate to a demo screen.
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo (placeholder)')));
              },
              child: const Text('Demo (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}