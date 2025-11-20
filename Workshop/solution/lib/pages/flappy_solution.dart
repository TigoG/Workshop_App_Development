/*
HIGH-LEVEL APPROACH:
- Timer-based game loop (Timer.periodic) at ~60 FPS updates the world.
- Bird uses simple vertical physics: position (px) and velocity (px/s). Gravity accelerates downward; a tap/space sets an immediate upward velocity (jump).
- Pipes are spawned periodically on the right with a randomized vertical gap; each pipe pair moves left at constant speed and is removed when off-screen. Passing a pipe increments score.
- Collision detection uses axis-aligned rectangles (bird vs pipe rects and vs top/ground).
- Game states: waiting-to-start, running, paused, game-over. Tap to start/jump, spacebar also jumps; pause/resume and restart controls provided.
TIPS: see bottom for explanation and instructor notes.
*/

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pipe {
  double x; // left position in pixels
  final double width;
  final double gapY; // top position of gap (px)
  final double gapHeight;
  bool passed = false;
  Pipe({
    required this.x,
    required this.width,
    required this.gapY,
    required this.gapHeight,
  });
}

class FlappySolutionPage extends StatefulWidget {
  const FlappySolutionPage({Key? key}) : super(key: key);
  static const String routeName = '/flappy';
  @override
  State<FlappySolutionPage> createState() => _FlappySolutionPageState();
}

class _FlappySolutionPageState extends State<FlappySolutionPage> {
  // Game constants
  static const int tickMs = 16; // ~60 FPS
  static const double gravity = 1500; // px/s^2
  static const double jumpVelocity = 420; // px/s (negative = up)
  static const double pipeSpeed = 200; // px/s
  static const double pipeWidth = 70;
  static const double pipeGap = 150;
  static const double pipeSpawnInterval = 1.6; // seconds
  static const double birdSize = 40;
  static const double groundHeight = 24;

  // Dynamic state
  Timer? _timer;
  double _birdY = 0; // top position in px
  double _birdV = 0; // vertical velocity px/s
  final List<Pipe> _pipes = [];
  double _timeSinceLastPipe = 0;
  int _score = 0;

  bool _isRunning = false; // started
  bool _isPaused = false;
  bool _isGameOver = false;

  double _gameWidth = 0;
  double _gameHeight = 0;

  final FocusNode _focusNode = FocusNode();
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();
    // Ensure keyboard events are received
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  // Start or restart the main game loop timer
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: tickMs), (_) => _onTick());
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // Reset game to initial state
  void _resetGame() {
    _stopTimer();
    _pipes.clear();
    _timeSinceLastPipe = 0;
    _score = 0;
    _birdV = 0;
    // Place bird vertically in center of playable area
    final playableHeight = max(0, _gameHeight - groundHeight);
    _birdY = (playableHeight - birdSize) / 2;
    _isGameOver = false;
    _isPaused = false;
    _isRunning = false;
    setState(() {});
  }

  // Apply upward impulse to the bird (jump)
  void _jump() {
    // If game over, tapping should restart handled by caller.
    _birdV = -jumpVelocity;
  }

  // Handle a tap / jump from user
  void _onTap() {
    if (_isGameOver) {
      // Restart the game when tapping after game over
      _resetGame();
      _isRunning = true;
      _startTimer();
      return;
    }
    if (!_isRunning) {
      // First tap starts the game loop
      _isRunning = true;
      _startTimer();
    }
    if (_isPaused) {
      // Resume when jumping while paused
      _isPaused = false;
    }
    _jump();
    setState(() {});
  }

  // Spawn a new pair of pipes at the right edge
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

  // Main tick: update physics, pipes, spawn, collisions, and scoring
  void _onTick() {
    if (!_isRunning || _isPaused || _isGameOver) return;
    final dt = tickMs / 1000.0;

    setState(() {
      // Update bird physics: gravity and integration
      _birdV += gravity * dt;
      _birdY += _birdV * dt;

      // Move pipes left
      for (final p in _pipes) {
        p.x -= pipeSpeed * dt;
      }

      // Spawn pipes periodically
      _timeSinceLastPipe += dt;
      if (_timeSinceLastPipe >= pipeSpawnInterval) {
        _timeSinceLastPipe = 0;
        _spawnPipe();
      }

      // Remove off-screen pipes
      _pipes.removeWhere((p) => p.x + p.width < 0);

      // Scoring: when bird passes pipe center
      final birdX = _gameWidth * 0.28; // fixed horizontal position of bird
      for (final p in _pipes) {
        if (!p.passed && p.x + p.width < birdX) {
          p.passed = true;
          _score += 1;
        }
      }

      // Collision detection: bird vs pipes and bounds
      if (_checkCollision()) {
        _isGameOver = true;
        _stopTimer();
      }
    });
  }

  // Check axis-aligned rectangle collisions
  bool _checkCollision() {
    final birdLeft = _gameWidth * 0.28 - birdSize / 2;
    final birdRect = Rect.fromLTWH(birdLeft, _birdY, birdSize, birdSize);

    // Collide with ceiling or ground
    if (_birdY <= 0 || _birdY + birdSize >= _gameHeight - groundHeight) {
      return true;
    }

    // Collide with any pipe
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

  // Toggle pause/resume state
  void _togglePause() {
    if (_isGameOver) return;
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  // Build a visual pipe pair
  Widget _buildPipe(Pipe p) {
    // Height calculations depend on current game area
    final topHeight = p.gapY;
    final bottomTop = p.gapY + p.gapHeight;
    final bottomHeight = max(0.0, (_gameHeight - groundHeight) - bottomTop);
    return Stack(
      children: [
        Positioned(
          left: p.x,
          top: 0,
          child: Container(
            width: p.width,
            height: topHeight,
            color: Colors.green[700],
          ),
        ),
        Positioned(
          left: p.x,
          top: bottomTop,
          child: Container(
            width: p.width,
            height: bottomHeight,
            color: Colors.green[700],
          ),
        ),
      ],
    );
  }

  // Build the bird widget
  Widget _buildBird() {
    final birdX = _gameWidth * 0.28;
    return Positioned(
      left: birdX - birdSize / 2,
      top: _birdY,
      child: Container(
        width: birdSize,
        height: birdSize,
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: const Center(
          child: Icon(Icons.flight, size: 18, color: Colors.black54),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solution — Beginner Flappy Bird'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Capture current game area size for physics calculations
          _gameWidth = constraints.maxWidth;
          _gameHeight = constraints.maxHeight;

          // Ensure bird is placed reasonably before the game starts
          if (!_isRunning && !_isGameOver && (_birdY == 0)) {
            final playableHeight = max(0, _gameHeight - groundHeight);
            _birdY = (playableHeight - birdSize) / 2;
          }

          return RawKeyboardListener(
            focusNode: _focusNode,
            onKey: (event) {
              if (event is RawKeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.space) {
                _onTap();
              }
            },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _onTap,
              child: Stack(
                children: [
                  // Sky background
                  Container(color: Colors.lightBlue[200]),
                  // Pipes
                  ..._pipes.map((p) => _buildPipe(p)),
                  // Bird
                  _buildBird(),
                  // Ground
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: groundHeight,
                      color: Colors.brown[400],
                    ),
                  ),
                  // HUD: Score and Pause button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text('Score: $_score',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                          color: Colors.white,
                          onPressed: _togglePause,
                          tooltip: _isPaused ? 'Resume' : 'Pause',
                        ),
                      ],
                    ),
                  ),
                  // Optional on-screen jump button (mobile friendly)
                  Positioned(
                    right: 12,
                    bottom: groundHeight + 12,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: _onTap,
                      child: const Icon(Icons.arrow_upward),
                    ),
                  ),
                  // Overlay: Waiting instructions
                  if (!_isRunning && !_isGameOver)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Tap or press SPACE to start and jump',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  // Overlay: Paused
                  if (_isPaused)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Paused',
                          style:
                              TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    ),
                  // Overlay: Game Over and Restart
                  if (_isGameOver)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Game Over',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('Score: $_score',
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                _resetGame();
                                _isRunning = true;
                                _startTimer();
                              },
                              child: const Text('Restart'),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
TIPS / EXPLANATION:
- This implementation uses simple per-frame updates with a Timer; an alternative is an AnimationController.
- Physics are basic: constant gravity and an instantaneous jump impulse. You can smooth motion with Verlet integration or tweak constants.
- Extensions: add multiple difficulty levels, animated bird rotation based on velocity, persistent high score, sound effects, or visual polish for pipes and parallax background.
- Instructor notes: this is intentionally small and uses only built-in widgets and math; it's a good exercise to refactor collision detection and separate rendering from state for testing.
*/