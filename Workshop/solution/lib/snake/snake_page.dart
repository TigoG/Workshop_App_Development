// UI using SnakeController
import 'dart:math';
import 'package:flutter/material.dart';
import 'snake_controller.dart';

class SnakeRefactorPage extends StatefulWidget {
  const SnakeRefactorPage({super.key});
  static const String routeName = '/snake_refactor';
  @override
  State<SnakeRefactorPage> createState() => _SnakeRefactorPageState();
}

class _SnakeRefactorPageState extends State<SnakeRefactorPage> {
  late final SnakeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SnakeController();
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _initializeBoardOnce(BoxConstraints constraints) {
    if (_controller.boardInitialized) return;
    final boardSize = min(constraints.maxWidth, constraints.maxHeight) * 0.95;
    const targetCell = 18.0;
    final cols = max(8, (boardSize / targetCell).floor());
    final cellSize = boardSize / cols;
    _controller.initializeBoard(cols: cols, rows: cols, cellSize: cellSize);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final dx = details.delta.dx;
    final dy = details.delta.dy;
    const threshold = 5;
    if (dx.abs() < threshold && dy.abs() < threshold) return;
    if (dx.abs() > dy.abs()) {
      if (dx > 0) {
        _controller.changeDirection(Direction.right);
      } else {
        _controller.changeDirection(Direction.left);
      }
    } else {
      if (dy > 0) {
        _controller.changeDirection(Direction.down);
      } else {
        _controller.changeDirection(Direction.up);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake'),
        actions: [
          IconButton(
            icon: Icon(_controller.paused ? Icons.play_arrow : Icons.pause),
            tooltip: _controller.paused ? 'Resume' : 'Pause',
            onPressed: _controller.running ? _controller.togglePause : null,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Restart game',
            onPressed: _controller.startNewGame,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Score: ${_controller.score}', style: const TextStyle(fontSize: 18)),
                  Row(
                    children: [
                      const Text('Speed (ms): '),
                      SizedBox(
                        width: 140,
                        child: Slider.adaptive(
                          min: 50,
                          max: 500,
                          divisions: 9,
                          value: _controller.tickMs.toDouble(),
                          label: '${_controller.tickMs}',
                          onChanged: (v) => _controller.setSpeed(v.round()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  _initializeBoardOnce(constraints);
                  final width = _controller.cols * _controller.cellSize;
                  final height = _controller.rows * _controller.cellSize;

                  return Center(
                    child: GestureDetector(
                      onPanUpdate: _onPanUpdate,
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.black87),
                        ),
                        child: Stack(
                          children: [
                            CustomPaint(
                              size: Size(width, height),
                              painter: GridPainter(rows: _controller.rows, cols: _controller.cols, cellSize: _controller.cellSize),
                            ),

                            for (int i = 0; i < _controller.snake.length; i++)
                              Positioned(
                                left: _controller.snake[i].x * _controller.cellSize,
                                top: _controller.snake[i].y * _controller.cellSize,
                                width: _controller.cellSize,
                                height: _controller.cellSize,
                                child: Container(
                                  margin: EdgeInsets.all(_controller.cellSize * 0.06),
                                  decoration: BoxDecoration(
                                    color: i == 0 ? Colors.green[800] : Colors.green,
                                    borderRadius: BorderRadius.circular(_controller.cellSize * 0.15),
                                  ),
                                ),
                              ),

                            if (_controller.apple != null)
                              Positioned(
                                left: _controller.apple!.x * _controller.cellSize,
                                top: _controller.apple!.y * _controller.cellSize,
                                width: _controller.cellSize,
                                height: _controller.cellSize,
                                child: Container(
                                  margin: EdgeInsets.all(_controller.cellSize * 0.08),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.local_pizza, size: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    iconSize: 36,
                    icon: const Icon(Icons.keyboard_arrow_up),
                    onPressed: () => _controller.changeDirection(Direction.up),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 36,
                        icon: const Icon(Icons.keyboard_arrow_left),
                        onPressed: () => _controller.changeDirection(Direction.left),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        iconSize: 36,
                        icon: const Icon(Icons.keyboard_arrow_right),
                        onPressed: () => _controller.changeDirection(Direction.right),
                      ),
                    ],
                  ),
                  IconButton(
                    iconSize: 36,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () => _controller.changeDirection(Direction.down),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final int rows;
  final int cols;
  final double cellSize;

  GridPainter({required this.rows, required this.cols, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // ignore: deprecated_member_use
      ..color = Colors.grey.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int c = 0; c <= cols; c++) {
      final x = c * cellSize;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (int r = 0; r <= rows; r++) {
      final y = r * cellSize;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.rows != rows || oldDelegate.cols != cols || oldDelegate.cellSize != cellSize;
  }
}