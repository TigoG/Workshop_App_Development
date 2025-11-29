// UI using LayoutController
import 'package:flutter/material.dart';
import 'layout_controller.dart';

class LayoutRefactorPage extends StatefulWidget {
  const LayoutRefactorPage({Key? key}) : super(key: key);
  static const String routeName = '/layout_refactor';
  @override
  State<LayoutRefactorPage> createState() => _LayoutRefactorPageState();
}

class _LayoutRefactorPageState extends State<LayoutRefactorPage> {
  late final LayoutController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LayoutController();
    _controller.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final effectiveMode = _controller.effectiveModeForWidth(width);

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

  Widget _buildControlPanel(double width) {
    return Row(
      children: [
        const Text('Mode:'),
        const SizedBox(width: 8),
        DropdownButton<LayoutMode>(
          value: _controller.mode,
          onChanged: (v) {
            if (v != null) _controller.setMode(v);
          },
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
                  value: _controller.gap,
                  onChanged: (v) => _controller.setGap(v),
                ),
              ),
              SizedBox(
                width: 48,
                child: Text(_controller.gap.toStringAsFixed(0), textAlign: TextAlign.right),
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
              value: _controller.showDebug,
              onChanged: (_) => _controller.toggleShowDebug(),
            ),
          ],
        ),
      ],
    );
  }

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
        Expanded(
          child: Container(
            padding: EdgeInsets.all(_controller.gap / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: _controller.showDebug ? Border.all(color: Colors.blueAccent) : null,
            ),
            child: _buildLayoutContent(mode, width),
          ),
        ),
        const SizedBox(height: 12),
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

  Widget _singleColumnWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _demoCard('Title', Icons.title, Colors.indigo),
          SizedBox(height: _controller.gap),
          _demoCard('Summary', Icons.subject, Colors.teal),
          SizedBox(height: _controller.gap),
          _demoCard('Actions', Icons.settings, Colors.orange),
        ],
      ),
    );
  }

  Widget _twoColumnWidget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _demoCard('Main content', Icons.dashboard, Colors.indigo),
              SizedBox(height: _controller.gap),
              _demoCard('More content', Icons.list, Colors.teal),
            ],
          ),
        ),
        SizedBox(width: _controller.gap),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _demoCard('Details', Icons.info, Colors.blueGrey),
              SizedBox(height: _controller.gap),
              _demoCard('Actions', Icons.play_arrow, Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _gridWidget(double width) {
    final desiredItemWidth = 160.0;
    final count = (width / desiredItemWidth).clamp(1, 6).floor();
    final crossAxisCount = count < 1 ? 1 : count;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: _controller.gap,
      mainAxisSpacing: _controller.gap,
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

  Widget _demoCard(String title, IconData icon, Color color) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: _controller.showDebug ? Border.all(color: color) : null,
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
            border: _controller.showDebug ? Border.all(color: Colors.green) : null,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.green[400],
                  child: const Center(child: Text('Expanded 2')),
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.yellow[700],
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Center(child: Text('Flexible 1')),
                ),
              ),
              const SizedBox(width: 6),
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