// FlappyController: encapsulates physics and pipe management for the Flappy example.
// Controller is a ChangeNotifier so UI pages can listen to state updates.
//
// Responsibilities:
// - Manage bird physics, pipe spawning, scoring and basic game state.
// - Run the game loop via internal Timer.
// - Expose API: initialize(size), reset, jump, togglePause, start/stop.

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Pipe {
  double x;
  final double width;
  final double gapY;
  final double gapHeight;
  bool passed = false;
  Pipe({
    required this.x,
    required this.width,
    required this.gapY,
    required this.gapHeight,
  });
}

enum FlappyState { waiting, running, paused, gameOver }

class FlappyController extends ChangeNotifier {
  // Game constants (default values)
  final int tickMs;
  final double gravity;
  final double jumpVelocity;
  final double pipeSpeed;
  final double pipeWidth;
  final double pipeGap;
  final double pipeSpawnInterval;
  final double birdSize;
  final double groundHeight;

  Timer? _timer;
  double _birdY = 0;
  double _birdV = 0;
  final List<Pipe> _pipes = [];
  double _timeSinceLastPipe = 0;
  int _score = 0;

  FlappyState _state = FlappyState.waiting;

  double _gameWidth = 0;
  double _gameHeight = 0;

  final Random _rng = Random();

  FlappyController({
    this.tickMs = 16,
    this.gravity = 1500,
    this.jumpVelocity = 420,
    this.pipeSpeed = 200,
    this.pipeWidth = 70,
    this.pipeGap = 150,
    this.pipeSpawnInterval = 1.6,
    this.birdSize = 40,
    this.groundHeight = 24,
  });

  // Getters
  List<Pipe> get pipes => List.unmodifiable(_pipes);
  double get birdY => _birdY;
  double get birdV => _birdV;
  int get score => _score;
  FlappyState get state => _state;
  double get gameWidth => _gameWidth;
  double get gameHeight => _gameHeight;

  // Initialize controller with available game area size
  void initialize(Size size) {
    _gameWidth = size.width;
    _gameHeight = size.height;
    _resetBirdPosition();
    notifyListeners();
  }

  void _resetBirdPosition() {
    final playableHeight = max(0, _gameHeight - groundHeight);
    _birdY = (playableHeight - birdSize) / 2;
    _birdV = 0;
  }

  void resetGame() {
    _stopTimer();
    _pipes.clear();
    _timeSinceLastPipe = 0;
    _score = 0;
    _resetBirdPosition();
    _state = FlappyState.waiting;
    notifyListeners();
  }

  void startGame() {
    if (_state == FlappyState.running) return;
    _state = FlappyState.running;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: tickMs), (_) => _onTick());
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void togglePause() {
    if (_state == FlappyState.gameOver) return;
    if (_state == FlappyState.paused) {
      _state = FlappyState.running;
      _startTimer();
    } else if (_state == FlappyState.running) {
      _state = FlappyState.paused;
      _stopTimer();
    }
    notifyListeners();
  }

  void jump() {
    if (_state == FlappyState.gameOver) return;
    if (_state != FlappyState.running) {
      startGame();
    }
    _birdV = -jumpVelocity;
    notifyListeners();
  }

  void _spawnPipe() {
    final playableHeight = max(0, _gameHeight - groundHeight);
    final maxTop = max(20.0, playableHeight - pipeGap - 40.0);
    final gapTop = 20 + _rng.nextDouble() * (maxTop - 20);
    final newPipe = Pipe(
      x: _gameWidth,
      width: pipeWidth,
      gapY: gapTop,
      gapHeight: pipeGap,
    );
    _pipes.add(newPipe);
  }

  void _onTick() {
    if (_state != FlappyState.running) return;
    final dt = tickMs / 1000.0;
    // update bird
    _birdV += gravity * dt;
    _birdY += _birdV * dt;
    // move pipes
    for (final p in _pipes) {
      p.x -= pipeSpeed * dt;
    }
    // spawn pipes
    _timeSinceLastPipe += dt;
    if (_timeSinceLastPipe >= pipeSpawnInterval) {
      _timeSinceLastPipe = 0;
      _spawnPipe();
    }
    // remove off-screen
    _pipes.removeWhere((p) => p.x + p.width < 0);
    // scoring
    final birdX = _gameWidth * 0.28;
    for (final p in _pipes) {
      if (!p.passed && p.x + p.width < birdX) {
        p.passed = true;
        _score += 1;
      }
    }
    // collision
    if (_checkCollision()) {
      _onGameOver();
    }
    notifyListeners();
  }

  bool _checkCollision() {
    final birdLeft = _gameWidth * 0.28 - birdSize / 2;
    final birdRect = Rect.fromLTWH(birdLeft, _birdY, birdSize, birdSize);
    // ceiling / ground
    if (_birdY <= 0 || _birdY + birdSize >= _gameHeight - groundHeight) {
      return true;
    }
    for (final p in _pipes) {
      final topRect = Rect.fromLTWH(p.x, 0, p.width, p.gapY);
      final bottomRect = Rect.fromLTWH(p.x, p.gapY + p.gapHeight, p.width,
          max(0.0, _gameHeight - groundHeight - (p.gapY + p.gapHeight)));
      if (birdRect.overlaps(topRect) || birdRect.overlaps(bottomRect)) {
        return true;
      }
    }
    return false;
  }

  void _onGameOver() {
    _state = FlappyState.gameOver;
    _stopTimer();
    notifyListeners();
  }

  void disposeController() {
    _stopTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}