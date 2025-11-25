// SnakeController: encapsulates game logic and state for the Snake example.
// This controller is a ChangeNotifier so UI code can listen and rebuild.
//
// Responsibilities:
// - Manage snake segments, apple placement, direction and score.
// - Run the game loop via an internal Timer.
// - Expose simple API: initializeBoard, startNewGame, changeDirection, togglePause, setSpeed.
//
// All state mutations call notifyListeners() so pages can update via a listener.
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum Direction { up, down, left, right }

class SnakeController extends ChangeNotifier {
  final Random _random = Random();

  // Game state
  List<Point<int>> _snake = [];
  Point<int>? _apple;
  Direction _direction = Direction.right;

  // Timing & control
  Timer? _timer;
  int _tickMs = 200;
  bool _running = false;
  bool _paused = false;

  // Board sizing
  bool _boardInitialized = false;
  int _rows = 20;
  int _cols = 20;
  double _cellSize = 16.0;

  // Score
  int _score = 0;

  // Getters
  List<Point<int>> get snake => List.unmodifiable(_snake);
  Point<int>? get apple => _apple;
  Direction get direction => _direction;
  int get rows => _rows;
  int get cols => _cols;
  double get cellSize => _cellSize;
  int get score => _score;
  bool get running => _running;
  bool get paused => _paused;
  bool get boardInitialized => _boardInitialized;
  int get tickMs => _tickMs;

  /// Initialize board parameters and start a new game.
  void initializeBoard({required int cols, required int rows, required double cellSize}) {
    _cols = cols;
    _rows = rows;
    _cellSize = cellSize;
    _boardInitialized = true;
    startNewGame();
    notifyListeners();
  }

  /// Start or restart the game (places snake and apple, resets score & timer).
  void startNewGame() {
    _timer?.cancel();
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

    _startTimer();
    notifyListeners();
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

  /// Advance the snake by one cell, handle apple eating and collisions.
  void _updateSnake() {
    if (_snake.isEmpty) return;
    final head = _snake.first;
    late Point<int> newHead;

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

    // Collision with itself
    if (_snake.contains(newHead)) {
      _onGameOver();
      return;
    }

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

    notifyListeners();
  }

  /// Place apple at a random free cell
  void _spawnApple() {
    if (_snake.length >= _rows * _cols) {
      _apple = null; // board full
      notifyListeners();
      return;
    }

    Point<int> p;
    do {
      p = Point(_random.nextInt(_cols), _random.nextInt(_rows));
    } while (_snake.contains(p));

    _apple = p;
    notifyListeners();
  }

  void _onGameOver() {
    _stopTimer();
    _running = false;
    notifyListeners();
  }

  /// Change direction (ignore if attempt to reverse)
  void changeDirection(Direction newDir) {
    if (_isOpposite(newDir, _direction) && _snake.length > 1) return;
    _direction = newDir;
    notifyListeners();
  }

  bool _isOpposite(Direction a, Direction b) {
    return (a == Direction.left && b == Direction.right) ||
        (a == Direction.right && b == Direction.left) ||
        (a == Direction.up && b == Direction.down) ||
        (a == Direction.down && b == Direction.up);
  }

  void togglePause() {
    _paused = !_paused;
    if (_paused) {
      _stopTimer();
    } else if (_running) {
      _startTimer();
    }
    notifyListeners();
  }

  void setSpeed(int ms) {
    _tickMs = ms;
    if (_running && !_paused) {
      _startTimer();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}