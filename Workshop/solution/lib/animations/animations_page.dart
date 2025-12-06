// Animations page with multiple demos (implicit & explicit)
import 'package:flutter/material.dart';

class AnimationsRefactorPage extends StatefulWidget {
  const AnimationsRefactorPage({super.key});
  static const String routeName = '/animations_refactor';

  @override
  State<AnimationsRefactorPage> createState() => _AnimationsRefactorPageState();
}

class _AnimationsRefactorPageState extends State<AnimationsRefactorPage> with TickerProviderStateMixin {
  // Implicit animation state
  bool _isBig = false;
  double _opacity = 1.0;
  Alignment _alignment = Alignment.centerLeft;
  bool _showFirst = true;
  bool _togglePosition = false;

  // Explicit animations
  late final AnimationController _spinScaleController;
  late final Animation<double> _rotationAnim;
  late final Animation<double> _scaleAnim;
  late final Animation<Color?> _colorAnim;

  late final AnimationController _staggerController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _staggerOpacity;
  late final Animation<double> _staggerScale;

  int _switchCounter = 0;

  @override
  void initState() {
    super.initState();

    _spinScaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _rotationAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _spinScaleController, curve: Curves.easeInOut));
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: _spinScaleController, curve: Curves.easeInOut));
    _colorAnim = ColorTween(begin: Colors.blue, end: Colors.pink).animate(CurvedAnimation(parent: _spinScaleController, curve: Curves.easeInOut));
    _spinScaleController.repeat(reverse: true);

    _staggerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _slideAnim = Tween<Offset>(begin: const Offset(-1.2, 0), end: Offset.zero).animate(CurvedAnimation(parent: _staggerController, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
    _staggerOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _staggerController, curve: const Interval(0.0, 0.35, curve: Curves.easeIn)));
    _staggerScale = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _staggerController, curve: const Interval(0.5, 1.0, curve: Curves.elasticOut)));
    _staggerController.forward();
  }

  @override
  void dispose() {
    _spinScaleController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animations')),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Text('Implicit animations', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                // AnimatedContainer demo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      width: _isBig ? 200 : 100,
                      height: _isBig ? 120 : 80,
                      decoration: BoxDecoration(color: _isBig ? Colors.teal : Colors.orange, borderRadius: BorderRadius.circular(_isBig ? 24 : 8)),
                      child: const Center(child: Icon(Icons.flutter_dash, size: 32, color: Colors.white)),
                    ),
                    ElevatedButton(onPressed: () => setState(() => _isBig = !_isBig), child: const Text('Toggle'))
                  ],
                ),
                const SizedBox(height: 12),

                // AnimatedOpacity demo
                Row(
                  children: [
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 500),
                      child: const FlutterLogo(size: 48),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: () => setState(() => _opacity = _opacity == 1.0 ? 0.2 : 1.0), child: const Text('Fade')),
                  ],
                ),
                const SizedBox(height: 12),

                // AnimatedAlign demo
                Container(
                  height: 80,
                  color: Colors.grey.shade50,
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    alignment: _alignment,
                    child: Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(onPressed: () => setState(() => _alignment = Alignment.centerLeft), child: const Text('Left')),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: () => setState(() => _alignment = Alignment.center), child: const Text('Center')),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: () => setState(() => _alignment = Alignment.centerRight), child: const Text('Right')),
                  ],
                ),

                const SizedBox(height: 8),
                // AnimatedCrossFade demo
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  firstChild: Container(padding: const EdgeInsets.all(8), color: Colors.greenAccent, child: const Text('First view')),
                  secondChild: Container(padding: const EdgeInsets.all(8), color: Colors.orangeAccent, child: const Text('Second view')),
                  crossFadeState: _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
                const SizedBox(height: 8),
                Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => setState(() => _showFirst = !_showFirst), child: const Text('Toggle cross-fade'))),
              ]),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Text('Explicit animations (AnimationController + Transitions)', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                // Rotation + Scale + Color using AnimatedBuilder and transitions
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotationTransition(
                      turns: _rotationAnim,
                      child: ScaleTransition(
                        scale: _scaleAnim,
                        child: AnimatedBuilder(
                          animation: _colorAnim,
                          builder: (context, child) {
                            return Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: _colorAnim.value, shape: BoxShape.circle), child: child);
                          },
                          child: const Icon(Icons.star, size: 40, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: [
                  ElevatedButton(onPressed: () => _spinScaleController.repeat(reverse: true), child: const Text('Start')),
                  ElevatedButton(onPressed: () => _spinScaleController.stop(), child: const Text('Stop')),
                  ElevatedButton(onPressed: () => _spinScaleController.forward(from: 0.0), child: const Text('Pulse')),
                ]),

                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                const Text('Staggered / Slide-in demo', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SlideTransition(
                  position: _slideAnim,
                  child: FadeTransition(
                    opacity: _staggerOpacity,
                    child: ScaleTransition(scale: _staggerScale, child: Container(padding: const EdgeInsets.all(12), color: Colors.blue.shade50, child: const Text('Staggered content'))),
                  ),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  ElevatedButton(onPressed: () => _staggerController.forward(from: 0.0), child: const Text('Animate in')),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: () => _staggerController.reverse(), child: const Text('Reverse')),
                ]),
              ]),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Text('Positioned / AnimatedPositioned', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        left: _togglePosition ? 220 : 8,
                        top: 16,
                        child: CircleAvatar(radius: 28, backgroundColor: Colors.deepPurple, child: const Icon(Icons.sentiment_satisfied, color: Colors.white)),
                      ),
                      Positioned(right: 8, bottom: 8, child: TextButton(onPressed: () => setState(() => _togglePosition = !_togglePosition), child: const Text('Move'))),
                    ],
                  ),
                ),
              ]),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Text('AnimatedSwitcher (switch between widgets)', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: ScaleTransition(scale: animation, child: child)),
                    child: Container(key: ValueKey<int>(_switchCounter), width: 120, height: 60, color: Colors.primaries[_switchCounter % Colors.primaries.length].shade300, child: Center(child: Text('#$_switchCounter', style: const TextStyle(fontSize: 18)))),
                  ),
                ),
                const SizedBox(height: 8),
                Align(alignment: Alignment.center, child: ElevatedButton(onPressed: () => setState(() => _switchCounter++), child: const Text('Next'))),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}