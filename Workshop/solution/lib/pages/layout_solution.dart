/*
HIGH-LEVEL APPROACH:
- Use LayoutBuilder and MediaQuery to detect available width and choose responsive breakpoints (example: 600 px).
- For narrow screens render a single-column vertical stack; for wide screens use a two-column Row with Expanded/Flexible.
- Grid examples use GridView.count with adaptive crossAxisCount computed from available width.
- Demonstrate Expanded vs Flexible with three colored boxes so students can see how space is shared.
- Interactive controls (Dropdown, Slider, Switch) allow toggling modes and spacing. Test responsiveness by resizing the window/emulator or switching the 'Auto' mode.

TIPS / EXPLANATION section below contains instructor notes and common pitfalls.
*/

import 'package:flutter/material.dart';

class LayoutSolutionPage extends StatefulWidget {
  const LayoutSolutionPage({Key? key}) : super(key: key);
  static const String routeName = '/layout';
  @override
  State<LayoutSolutionPage> createState() => _LayoutSolutionPageState();
}

enum LayoutMode { auto, single, twoColumn, grid }

class _LayoutSolutionPageState extends State<LayoutSolutionPage> {
  LayoutMode _mode = LayoutMode.auto;
  double _gap = 12.0;
  bool _showDebug = false;

  static const double _breakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout — Solution')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            // Determine effective mode when in Auto
            final effectiveMode = _mode == LayoutMode.auto
                ? (width < _breakpoint ? LayoutMode.single : LayoutMode.twoColumn)
                : _mode;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildControlPanel(width),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _buildPreview(effectiveMode, width),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Control panel with Dropdown, Slider, and Debug switch
  Widget _buildControlPanel(double width) {
    return Row(
      children: [
        const Text('Mode:'),
        const SizedBox(width: 8),
        DropdownButton<LayoutMode>(
          value: _mode,
          onChanged: (v) => setState(() {
            if (v != null) _mode = v;
          }),
          items: const [
            DropdownMenuItem(value: LayoutMode.auto, child: Text('Auto')),
            DropdownMenuItem(value: LayoutMode.single, child: Text('Single Column')),
            DropdownMenuItem(value: LayoutMode.twoColumn, child: Text('Two Column')),
            DropdownMenuItem(value: LayoutMode.grid, child: Text('Grid')),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              const Text('Gap:'),
              Expanded(
                child: Slider(
                  min: 0,
                  max: 32,
                  value: _gap,
                  onChanged: (v) => setState(() => _gap = v),
                ),
              ),
              SizedBox(
                width: 48,
                child: Text(_gap.toStringAsFixed(0), textAlign: TextAlign.right),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Debug'),
            Switch(
              value: _showDebug,
              onChanged: (v) => setState(() => _showDebug = v),
            ),
          ],
        ),
      ],
    );
  }

  // Build the live preview area. Show main layout and a flex demo below it.
  Widget _buildPreview(LayoutMode mode, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            'Preview: ${_modeLabel(mode)} (available width: ${width.toStringAsFixed(0)} px)',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        // The main example area; allow it to take available space
        Expanded(
          child: Container(
            padding: EdgeInsets.all(_gap / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: _showDebug ? Border.all(color: Colors.blueAccent) : null,
            ),
            child: _buildLayoutContent(mode, width),
          ),
        ),
        const SizedBox(height: 12),
        // Always include the Expanded vs Flexible demonstration
        _buildFlexDemo(),
      ],
    );
  }

  String _modeLabel(LayoutMode m) {
    switch (m) {
      case LayoutMode.auto:
        return 'Auto';
      case LayoutMode.single:
        return 'Single Column';
      case LayoutMode.twoColumn:
        return 'Two Column';
      case LayoutMode.grid:
        return 'Grid';
    }
  }

  Widget _buildLayoutContent(LayoutMode mode, double width) {
    switch (mode) {
      case LayoutMode.single:
        return _singleColumnWidget();
      case LayoutMode.twoColumn:
        return _twoColumnWidget();
      case LayoutMode.grid:
        return _gridWidget(width);
      default:
        return _singleColumnWidget();
    }
  }

  // Single-column layout: stacked cards
  Widget _singleColumnWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _demoCard('Title', Icons.title, Colors.indigo),
          SizedBox(height: _gap),
          _demoCard('Summary', Icons.subject, Colors.teal),
          SizedBox(height: _gap),
          _demoCard('Actions', Icons.settings, Colors.orange),
        ],
      ),
    );
  }

  // Two-column layout: responsive row using Expanded/Flexible
  Widget _twoColumnWidget() {
    return Row(
      children: [
        // Left column: main content (takes more space)
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _demoCard('Main content', Icons.dashboard, Colors.indigo),
              SizedBox(height: _gap),
              _demoCard('More content', Icons.list, Colors.teal),
            ],
          ),
        ),
        SizedBox(width: _gap),
        // Right column: details (fixed or flexible)
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _demoCard('Details', Icons.info, Colors.blueGrey),
              SizedBox(height: _gap),
              _demoCard('Actions', Icons.play_arrow, Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  // Grid example: crossAxisCount adapts to available width
  Widget _gridWidget(double width) {
    // Compute an approximate column count based on desired item width
    final desiredItemWidth = 160.0;
    final count = (width / desiredItemWidth).clamp(1, 6).floor();
    final crossAxisCount = count < 1 ? 1 : count;

    // Use GridView.count with shrinkWrap so it works inside Column
    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: _gap,
      mainAxisSpacing: _gap,
      children: List.generate(6, (i) {
        final titles = ['One', 'Two', 'Three', 'Four', 'Five', 'Six'];
        final colors = [Colors.indigo, Colors.teal, Colors.orange, Colors.purple, Colors.cyan, Colors.lime];
        final icons = [Icons.looks_one, Icons.looks_two, Icons.looks_3, Icons.looks_4, Icons.looks_5, Icons.looks_6];
        return _demoCard(titles[i], icons[i], colors[i]);
      }),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  // A single reusable demo "card"
  Widget _demoCard(String title, IconData icon, Color color) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: _showDebug ? Border.all(color: color) : null,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('Short description to show wrapping and spacing.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Demonstrate Expanded vs Flexible
  Widget _buildFlexDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Expanded vs Flexible demo', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
            border: _showDebug ? Border.all(color: Colors.green) : null,
          ),
          child: Row(
            children: [
              // Expanded: forces the child to fill available space (tight)
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.green[400],
                  child: const Center(child: Text('Expanded 2')),
                ),
              ),
              const SizedBox(width: 6),
              // Flexible with loose fit: child can be its intrinsic size
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.yellow[700],
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Center(child: Text('Flexible 1')),
                ),
              ),
              const SizedBox(width: 6),
              // Expanded again
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue[400],
                  child: const Center(child: Text('Expanded 1')),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Notes: Expanded uses a tight fit and forces its child to fill the space; Flexible (default loose fit) lets the child have its intrinsic size while participating in flex allocation.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

/*
TIPS / EXPLANATION (for instructors)

- LayoutBuilder vs MediaQuery:
  - Use LayoutBuilder when you care about the parent's constraints (often more precise for adapting widgets inside a given container).
  - Use MediaQuery when you need global information about the whole screen (device orientation, padding, textScaleFactor).

- Breakpoints:
  - Choose clear breakpoints (e.g., 600px for small vs large) and keep them consistent across the app.
  - Test in different device sizes and orientations (resize the emulator or run in a browser).

- Column, Row, Flex, Expanded, Flexible:
  - Expanded = Flexible(fit: FlexFit.tight) — forces its child to fill the allocated space.
  - Flexible (default loose fit) allows the child to have its intrinsic size while still being part of the flex layout.
  - Common pitfall: placing unbounded-height children (e.g., ListView) inside Column without wrapping in Expanded—this causes layout errors.

- GridView:
  - GridView.count is handy for quick responsive grids. Use shrinkWrap and NeverScrollableScrollPhysics when nesting in another scrollable area.

- Accessibility:
  - Respect textScaleFactor and provide sufficient hit targets for interactive widgets.

- Extensions for students:
  - Add animation when switching layouts, introduce AdaptiveLayout that swaps widgets entirely, or show an overlay comparing layouts side-by-side.

*/