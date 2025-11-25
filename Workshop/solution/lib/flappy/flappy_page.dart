//UI using FlappyController
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flappy_controller.dart';

class FlappyRefactorPage extends StatefulWidget {
  const FlappyRefactorPage({Key? key}) : super(key: key);
  static const String routeName = '/flappy_refactor';
  @override
  State<FlappyRefactorPage> createState() => _FlappyRefactorPageState();
}

class _FlappyRefactorPageState extends State<FlappyRefactorPage> {
  late final FlappyController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = FlappyController();
    _controller.addListener(_onControllerChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _onControllerChanged() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_controller.state == FlappyState.gameOver) {
      _controller.resetGame();
      _controller.startGame();
      return;
    }
    _controller.jump();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flappy — Refactored')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          if (_controller.gameWidth != size.width || _controller.gameHeight != size.height) {
            _controller.initialize(size);
          }

          return RawKeyboardListener(
            focusNode: _focusNode,
            onKey: (event) {
              if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
                _onTap();
              }
            },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _onTap,
              child: Stack(
                children: [
                  Container(color: Colors.lightBlue[200]),
                  // Pipes
                  ..._controller.pipes.map((p) => _buildPipe(p)),
                  // Bird
                  _buildBird(),
                  // Ground
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: _controller.groundHeight,
                      color: Colors.brown[400],
                    ),
                  ),
                  // HUD: Score
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Score: ${_controller.score}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(_controller.state == FlappyState.paused ? Icons.play_arrow : Icons.pause),
                      color: Colors.white,
                      onPressed: _controller.togglePause,
                      tooltip: _controller.state == FlappyState.paused ? 'Resume' : 'Pause',
                    ),
                  ),
                  // Jump button (mobile)
                  Positioned(
                    right: 12,
                    bottom: _controller.groundHeight + 12,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: _onTap,
                      child: const Icon(Icons.arrow_upward),
                    ),
                  ),
                  // Overlay: Waiting
                  if (_controller.state == FlappyState.waiting)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(8)),
                        child: const Text('Tap or press SPACE to start and jump', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  // Overlay: Paused
                  if (_controller.state == FlappyState.paused)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                        child: const Text('Paused', style: TextStyle(fontSize: 28, color: Colors.white)),
                      ),
                    ),
                  // Overlay: Game Over
                  if (_controller.state == FlappyState.gameOver)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Game Over', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('Score: ${_controller.score}', style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                _controller.resetGame();
                                _controller.startGame();
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

  Widget _buildPipe(Pipe p) {
    final topHeight = p.gapY;
    final bottomTop = p.gapY + p.gapHeight;
    final bottomHeight = math.max(0.0, _controller.gameHeight - _controller.groundHeight - bottomTop);
    return Positioned(
      left: p.x,
      top: 0,
      child: Column(
        children: [
          Container(width: p.width, height: topHeight, color: Colors.green[700]),
          const SizedBox(height: 0),
          Container(width: p.width, height: bottomHeight, color: Colors.green[700]),
        ],
      ),
    );
  }

  Widget _buildBird() {
    final birdX = _controller.gameWidth * 0.28;
    return Positioned(
      left: birdX - _controller.birdSize / 2,
      top: _controller.birdY,
      child: Container(
        width: _controller.birdSize,
        height: _controller.birdSize,
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: const Center(child: Icon(Icons.flight, size: 18, color: Colors.black54)),
      ),
    );
  }
}