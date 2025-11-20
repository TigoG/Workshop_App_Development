import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/*
 HIGH-LEVEL APPROACH
 - Create a square game board sized to fit the available screen space.
 - Use a grid of integer coordinates (x,y). The number of rows/columns is computed
   based on the available board size so cells reasonably fit most devices.
 - The snake is represented as a List<Point<int>> where index 0 is the head.
 - A periodic Timer (tick) advances the snake by one cell at each interval.
 - An apple is spawned at a random free cell. Eating the apple grows the snake.
 - Swipe gestures and on-screen arrow buttons change the snake's direction.
 - Collisions with walls or the snake's body end the game; users can restart.
*/

enum Direction { up, down, left, right }

class SnakeSolutionPage extends StatefulWidget {
  const SnakeSolutionPage({super.key});
  static const String routeName = '/snake';
  @override
  State<SnakeSolutionPage> createState() => _SnakeSolutionPageState();
}

class _SnakeSolutionPageState extends State<SnakeSolutionPage> {
  final Random _random = Random();

  // Game state
  List<Point<int>> _snake = [];
  Point<int>? _apple;
  Direction _direction = Direction.right;

  // Timing & control
  Timer? _timer;
  int _tickMs = 200; // milliseconds per step; adjustable with a slider
  bool _running = false;
  bool _paused = false;

  // Board sizing (computed from available space)
  bool _boardInitialized = false;
  int _rows = 20;
  int _cols = 20;
  double _cellSize = 16.0;

  // Score
  int _score = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Initialize board based on available size (called from LayoutBuilder)
  void _initializeBoard(Size size) {
    final boardSize = min(size.width, size.height) * 0.95;
    const targetCell = 18.0;
    int cols = max(8, (boardSize / targetCell).floor());
    double cellSize = boardSize / cols;

    setState(() {
      _cols = cols;
      _rows = cols; // keep square cells
      _cellSize = cellSize;
      _boardInitialized = true;
    });

    _startNewGame();
  }

  // Start or restart the game: place snake and apple, reset score & timer
  void _startNewGame() {
    _timer?.cancel();
    setState(() {
      _snake = [];
      final centerX = (_cols / 2).floor();
      final centerY = (_rows / 2).floor();
      // initial snake: 3 segments horizontally pointing right
      _snake.add(Point(centerX, centerY));
      _snake.add(Point(centerX - 1, centerY));
      _snake.add(Point(centerX - 2, centerY));

      _direction = Direction.right;
      _score = 0;
      _running = true;
      _paused = false;
      _spawnApple();
    });

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: _tickMs), (_) {
      if (!_paused && _running) {
        _updateSnake();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // Advance the snake by one cell, handle apple eating and collisions.
  void _updateSnake() {
    final head = _snake.first;
    Point<int> newHead;

    switch (_direction) {
      case Direction.up:
        newHead = Point(head.x, head.y - 1);
        break;
      case Direction.down:
        newHead = Point(head.x, head.y + 1);
        break;
      case Direction.left:
        newHead = Point(head.x - 1, head.y);
        break;
      case Direction.right:
        newHead = Point(head.x + 1, head.y);
        break;
    }

    // Collision with walls
    if (newHead.x < 0 || newHead.x >= _cols || newHead.y < 0 || newHead.y >= _rows) {
      _onGameOver();
      return;
    }

    // Collision with itself (skip checking head)
    if (_snake.contains(newHead)) {
      _onGameOver();
      return;
    }

    setState(() {
      // Insert new head
      _snake.insert(0, newHead);

      // If apple eaten, grow snake and spawn new apple
      if (_apple != null && newHead == _apple) {
        _score += 1;
        _spawnApple();
      } else {
        // remove tail otherwise (snake moves forward)
        _snake.removeLast();
      }
    });
  }

  // Place apple at a random free cell
  void _spawnApple() {
    if (_snake.length >= _rows * _cols) {
      setState(() => _apple = null); // board full
      return;
    }

    Point<int> p;
    do {
      p = Point(_random.nextInt(_cols), _random.nextInt(_rows));
    } while (_snake.contains(p));

    setState(() {
      _apple = p;
    });
  }

  void _onGameOver() {
    _stopTimer();
    setState(() {
      _running = false;
    });

    // show dialog with final score and option to restart
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game over'),
        content: Text('Your score: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startNewGame();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  // Change direction (ignore if attempt to reverse)
  void _changeDirection(Direction newDir) {
    if (_isOpposite(newDir, _direction) && _snake.length > 1) return;
    setState(() {
      _direction = newDir;
    });
  }

  bool _isOpposite(Direction a, Direction b) {
    return (a == Direction.left && b == Direction.right) ||
        (a == Direction.right && b == Direction.left) ||
        (a == Direction.up && b == Direction.down) ||
        (a == Direction.down && b == Direction.up);
  }

  void _togglePause() {
    setState(() {
      _paused = !_paused;
    });

    if (_paused) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  // Handle swipe gestures to change direction
  void _onPanUpdate(DragUpdateDetails details) {
    final dx = details.delta.dx;
    final dy = details.delta.dy;

    // Ignore tiny movements
    const threshold = 5;
    if (dx.abs() < threshold && dy.abs() < threshold) return;

    if (dx.abs() > dy.abs()) {
      if (dx > 0) {
        _changeDirection(Direction.right);
      } else {
        _changeDirection(Direction.left);
      }
    } else {
      if (dy > 0) {
        _changeDirection(Direction.down);
      } else {
        _changeDirection(Direction.up);
      }
    }
  }

  // Adjust speed (ms per tick). Restart timer if running.
  void _setSpeed(int ms) {
    setState(() {
      _tickMs = ms;
    });
    if (_running && !_paused) {
      _startTimer();
    }
  }

  // Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake — Solution'),
        actions: [
          IconButton(
            icon: Icon(_paused ? Icons.play_arrow : Icons.pause),
            tooltip: _paused ? 'Resume' : 'Pause',
            onPressed: _running ? _togglePause : null,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Restart game',
            onPressed: _startNewGame,
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
                  Text('Score: $_score', style: const TextStyle(fontSize: 18)),
                  Row(
                    children: [
                      const Text('Speed (ms): '),
                      SizedBox(
                        width: 140,
                        child: Slider.adaptive(
                          min: 50,
                          max: 500,
                          divisions: 9,
                          value: _tickMs.toDouble(),
                          label: '$_tickMs',
                          onChanged: (v) => _setSpeed(v.round()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Game board
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final boardSize = min(constraints.maxWidth, constraints.maxHeight);
                  if (!_boardInitialized) {
                    // initialize board once we know the available size
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _initializeBoard(Size(constraints.maxWidth, constraints.maxHeight));
                    });
                  }

                  final width = _cols * _cellSize;
                  final height = _rows * _cellSize;

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
                            // grid painter (faint lines)
                            CustomPaint(
                              size: Size(width, height),
                              painter: _GridPainter(rows: _rows, cols: _cols, cellSize: _cellSize),
                            ),

                            // snake segments
                            for (int i = 0; i < _snake.length; i++)
                              Positioned(
                                left: _snake[i].x * _cellSize,
                                top: _snake[i].y * _cellSize,
                                width: _cellSize,
                                height: _cellSize,
                                child: Container(
                                  margin: EdgeInsets.all(_cellSize * 0.06),
                                  decoration: BoxDecoration(
                                    color: i == 0 ? Colors.green[800] : Colors.green,
                                    borderRadius: BorderRadius.circular(_cellSize * 0.15),
                                  ),
                                ),
                              ),

                            // apple
                            if (_apple != null)
                              Positioned(
                                left: _apple!.x * _cellSize,
                                top: _apple!.y * _cellSize,
                                width: _cellSize,
                                height: _cellSize,
                                child: Container(
                                  margin: EdgeInsets.all(_cellSize * 0.08),
                                  decoration: BoxDecoration(
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

            // Controls (on-screen directional buttons)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    iconSize: 36,
                    icon: const Icon(Icons.keyboard_arrow_up),
                    onPressed: () => _changeDirection(Direction.up),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 36,
                        icon: const Icon(Icons.keyboard_arrow_left),
                        onPressed: () => _changeDirection(Direction.left),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        iconSize: 36,
                        icon: const Icon(Icons.keyboard_arrow_right),
                        onPressed: () => _changeDirection(Direction.right),
                      ),
                    ],
                  ),
                  IconButton(
                    iconSize: 36,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () => _changeDirection(Direction.down),
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

// Paint faint grid lines so students can see the cells
class _GridPainter extends CustomPainter {
  final int rows;
  final int cols;
  final double cellSize;

  _GridPainter({required this.rows, required this.cols, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // vertical lines
    for (int c = 0; c <= cols; c++) {
      final x = c * cellSize;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // horizontal lines
    for (int r = 0; r <= rows; r++) {
      final y = r * cellSize;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.rows != rows || oldDelegate.cols != cols || oldDelegate.cellSize != cellSize;
  }
}

/*
 TIPS / EXPLANATION
 - This implementation keeps the logic intentionally compact:
   - Grid coordinates use integers (Point<int>) so movement and collision are simple equality checks.
   - Timer.periodic drives game updates instead of an animation controller; this is easier to reason about for beginners.
   - Swipe gestures and buttons both call into _changeDirection so input handling is centralized.
 - Extensions:
   - Add levels with increasing speed, obstacles, or wrap-around borders.
   - Persist high scores with shared_preferences.
   - Replace simple Containers with images or sprites for polish.
 */