// UI using StateController
import 'package:flutter/material.dart';
import 'state_controller.dart';

// Simple InheritedNotifier wrapper to expose the controller's inherited notifier
class CounterInherited extends InheritedNotifier<ValueNotifier<int>> {
  const CounterInherited({Key? key, required ValueNotifier<int> notifier, required Widget child})
      : super(key: key, notifier: notifier, child: child);

  static ValueNotifier<int> of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<CounterInherited>();
    assert(widget != null, 'No CounterInherited found in context');
    return widget!.notifier!;
  }
}

class StateRefactorPage extends StatefulWidget {
  const StateRefactorPage({Key? key}) : super(key: key);
  static const String routeName = '/state_refactor';
  @override
  State<StateRefactorPage> createState() => _StateRefactorPageState();
}

class _StateRefactorPageState extends State<StateRefactorPage> {
  late final StateController _controller;

  @override
  void initState() {
    super.initState();
    _controller = StateController();
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
      appBar: AppBar(title: const Text('State Management — Refactored')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('1) Local setState'),
            _localSetStateCard(),
            const SizedBox(height: 12),
            _sectionTitle('2) Lifting state up'),
            _liftingStateCard(),
            const SizedBox(height: 12),
            _sectionTitle('3) ValueNotifier / ValueListenableBuilder'),
            _valueNotifierCard(),
            const SizedBox(height: 12),
            _sectionTitle('4) InheritedWidget / InheritedNotifier'),
            _inheritedWidgetCard(),
            const SizedBox(height: 12),
            _sectionTitle('5) Navigation (push / await / pop result)'),
            _navigationCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 6.0), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)));

  Widget _localSetStateCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Local setState (state lives inside this widget):'),
            SizedBox(height: 8),
            LocalCounterRefactor(),
          ]),
        ),
      );

  Widget _liftingStateCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Lifting state up (parent owns the state, child calls back):'),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Parent counter: ', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 8),
                Text('${_controller.liftedCounter}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            LiftingChildRefactor(
              value: _controller.liftedCounter,
              onIncrement: _controller.incrementLifted,
              onDecrement: _controller.decrementLifted,
              onReset: _controller.resetLifted,
            ),
          ]),
        ),
      );

  Widget _valueNotifierCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('ValueNotifier + ValueListenableBuilder (reactive, lightweight):'),
            const SizedBox(height: 8),
            _controller.valueNotifier == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Notifier disposed'),
                      ElevatedButton(onPressed: () => _controller.recreateValueNotifier(), child: const Text('Recreate')),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: _controller.valueNotifier!,
                        builder: (context, value, _) {
                          return Text('Notifier value: $value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton(onPressed: () => _controller.incrementValueNotifier(), child: const Text('+')),
                          const SizedBox(width: 8),
                          ElevatedButton(onPressed: () => _controller.decrementValueNotifier(), child: const Text('-')),
                          const SizedBox(width: 8),
                          ElevatedButton(onPressed: () => _controller.resetValueNotifier(), child: const Text('Reset')),
                          const SizedBox(width: 12),
                          ElevatedButton(onPressed: () => _controller.disposeValueNotifier(), child: const Text('Dispose')),
                        ],
                      ),
                    ],
                  ),
          ]),
        ),
      );

  Widget _inheritedWidgetCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CounterInherited(
            notifier: _controller.inheritedCounter,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('InheritedWidget (CounterInherited) example:'),
              const SizedBox(height: 8),
              const Text('Below is a deep child that reads and updates the shared counter:'),
              const SizedBox(height: 8),
              Container(padding: const EdgeInsets.all(8), color: Colors.grey.shade50, child: const Padding(padding: EdgeInsets.all(6.0), child: DeepInheritedChildRefactor())),
            ]),
          ),
        ),
      );

  Widget _navigationCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Navigation (push, await result):'),
            const SizedBox(height: 8),
            Text('Last result: ${_controller.navResult}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(onPressed: _openSelector, child: const Text('Open selector page')),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () => _controller.setNavResult('Cleared'), child: const Text('Clear')),
              ],
            ),
          ]),
        ),
      );

  Future<void> _openSelector() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => const SelectionPageRefactor(
          title: 'Pick a color',
          options: ['Red', 'Green', 'Blue'],
        ),
      ),
    );
    if (!mounted) return;
    _controller.setNavResult(result ?? 'Cancelled');
  }
}

// LocalCounterRefactor
class LocalCounterRefactor extends StatefulWidget {
  const LocalCounterRefactor({Key? key}) : super(key: key);
  @override
  State<LocalCounterRefactor> createState() => _LocalCounterRefactorState();
}

class _LocalCounterRefactorState extends State<LocalCounterRefactor> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.remove), onPressed: () => setState(() => _count--)),
        Text('$_count', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => _count++)),
        const SizedBox(width: 8),
        OutlinedButton(onPressed: () => setState(() => _count = 0), child: const Text('Reset')),
      ],
    );
  }
}

// LiftingChildRefactor
class LiftingChildRefactor extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  const LiftingChildRefactor({Key? key, required this.value, required this.onIncrement, required this.onDecrement, required this.onReset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove)),
        Text('$value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(onPressed: onIncrement, icon: const Icon(Icons.add)),
        const SizedBox(width: 8),
        TextButton(onPressed: onReset, child: const Text('Reset')),
      ],
    );
  }
}

// DeepInheritedChildRefactor
class DeepInheritedChildRefactor extends StatelessWidget {
  const DeepInheritedChildRefactor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = CounterInherited.of(context);
    return ValueListenableBuilder<int>(
      valueListenable: notifier,
      builder: (context, value, _) {
        return Row(
          children: [
            Text('Inherited counter: ', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 6),
            Text('$value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => notifier.value = notifier.value + 1, tooltip: 'Increment via inherited notifier'),
          ],
        );
      },
    );
  }
}

// SelectionPageRefactor
class SelectionPageRefactor extends StatelessWidget {
  final String title;
  final List<String> options;

  const SelectionPageRefactor({Key? key, required this.title, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: options.length + 1,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index == options.length) {
            return ListTile(title: const Text('Cancel', style: TextStyle(color: Colors.red)), onTap: () => Navigator.of(context).pop(null));
          }
          final option = options[index];
          return ListTile(title: Text(option), onTap: () => Navigator.of(context).pop(option));
        },
      ),
    );
  }
}