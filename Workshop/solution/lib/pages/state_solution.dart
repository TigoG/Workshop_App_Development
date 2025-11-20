/*
HIGH-LEVEL APPROACH:
- Local setState for simple widgets:
  Use when a widget owns a small piece of UI state (e.g., a counter inside a single card).
  Call setState(() { ... }) inside the widget's State to trigger a rebuild of that widget subtree.

- Lifting state up to a parent:
  When multiple widgets need access to the same state, move the state to the nearest common ancestor
  and pass the current value + callbacks down to children. Children remain stateless and call the callbacks
  to request state changes.

- Reactive pattern using ValueNotifier / ValueListenableBuilder:
  ValueNotifier<T> is a lightweight observable. Wrap UI with ValueListenableBuilder to rebuild only
  the pieces that depend on the notifier. Remember to dispose the notifier when appropriate.

- InheritedWidget / InheritedNotifier basics:
  Use an InheritedWidget (or InheritedNotifier) to expose shared data to deep subtrees. Descendants call
  MyInherited.of(context) to obtain the shared value or notifier; using dependOnInheritedWidgetOfExactType
  registers them for rebuilds when the inherited widget notifies.

- How navigation interacts with state (passing arguments, awaiting results):
  Pass arguments via the pushed page's constructor (or route settings). Await Navigator.push(...) to receive
  a result when the pushed page pops with Navigator.pop(context, result).
*/

import 'package:flutter/material.dart';

// Minimal InheritedWidget using InheritedNotifier to hold a ValueNotifier<int>.
// Demonstrates how descendants can depend on shared state and rebuild when the notifier changes.
class CounterInherited extends InheritedNotifier<ValueNotifier<int>> {
  const CounterInherited({
    Key? key,
    required ValueNotifier<int> notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  // Helper to access the notifier from descendants.
  // Calling this registers the descendant for rebuilds when notifier changes.
  static ValueNotifier<int> of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<CounterInherited>();
    assert(widget != null, 'No CounterInherited found in context');
    return widget!.notifier!;
  }
}

class StateSolutionPage extends StatefulWidget {
  const StateSolutionPage({Key? key}) : super(key: key);
  static const String routeName = '/state';
  @override
  State<StateSolutionPage> createState() => _StateSolutionPageState();
}

class _StateSolutionPageState extends State<StateSolutionPage> {
  // Parent state for "lifting state up" example.
  int _liftedCounter = 0;

  // ValueNotifier example (created and disposed by this State).
  ValueNotifier<int>? _valueNotifier;

  // Inherited widget's notifier (shared via CounterInherited).
  final ValueNotifier<int> _inheritedNotifier = ValueNotifier<int>(0);

  // Navigation result storage.
  String _navResult = 'No result yet';

  @override
  void initState() {
    super.initState();
    // Initialize the ValueNotifier used in the ValueListenableBuilder example.
    _valueNotifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    // Dispose any notifiers owned by this State to avoid memory leaks.
    _valueNotifier?.dispose();
    _inheritedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('State Management — Solution')),
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

  // Small helper to render section titles.
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // 1) Local setState example: the card contains a widget that manages its own state.
  Widget _localSetStateCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Local setState (state lives inside this widget):'),
            SizedBox(height: 8),
            LocalCounterCard(),
          ],
        ),
      ),
    );
  }

  // 2) Lifting state up example: the parent holds the counter value and provides
  // callbacks to a (stateless) child which triggers changes.
  Widget _liftingStateCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lifting state up (parent owns the state, child calls back):'),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Parent counter: ', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 8),
                Text('$_liftedCounter', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            // Child receives value and callbacks. This demonstrates that the
            // child's actions change the parent's state via callbacks.
            LiftingChild(
              value: _liftedCounter,
              onIncrement: () => setState(() => _liftedCounter++),
              onDecrement: () => setState(() => _liftedCounter--),
              onReset: () => setState(() => _liftedCounter = 0),
            ),
          ],
        ),
      ),
    );
  }

  // 3) ValueNotifier example: reactive pattern using ValueListenableBuilder.
  Widget _valueNotifierCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ValueNotifier + ValueListenableBuilder (reactive, lightweight):'),
            const SizedBox(height: 8),
            // If the notifier has been disposed (for demo) show a placeholder.
            _valueNotifier == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Notifier disposed'),
                      ElevatedButton(
                        onPressed: () => setState(() => _valueNotifier = ValueNotifier<int>(0)),
                        child: const Text('Recreate'),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: _valueNotifier!,
                        builder: (context, value, _) {
                          // Only this builder is rebuilt when notifier.value changes.
                          return Text('Notifier value: $value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _valueNotifier!.value++,
                            child: const Text('+'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _valueNotifier!.value = _valueNotifier!.value - 1,
                            child: const Text('-'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _valueNotifier!.value = 0,
                            child: const Text('Reset'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              // Dispose to demonstrate lifecycle / cleanup.
                              _valueNotifier!.dispose();
                              setState(() => _valueNotifier = null);
                            },
                            child: const Text('Dispose'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  // 4) InheritedWidget example: provide shared state deep in the subtree.
  Widget _inheritedWidgetCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CounterInherited(
          notifier: _inheritedNotifier,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('InheritedWidget (CounterInherited) example:'),
              const SizedBox(height: 8),
              const Text('Below is a deep child that reads and updates the shared counter:'),
              const SizedBox(height: 8),
              // This child is placed "deep" in the tree to emphasize lookup via context.
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey.shade50,
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: DeepInheritedChild(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 5) Navigation demo: push a new page, await a result, and use it.
  Widget _navigationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Navigation (push, await a result, pop with result):'),
            const SizedBox(height: 8),
            Text('Last result: $_navResult', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _openSelector,
                  child: const Text('Open selector page'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _navResult = 'Cleared'),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper to push a selection page and await its result.
  Future<void> _openSelector() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => const SelectionPage(
          title: 'Pick a color',
          options: ['Red', 'Green', 'Blue'],
        ),
      ),
    );

    if (!mounted) return;
    setState(() {
      _navResult = result ?? 'Cancelled';
    });
  }
}

// LocalCounterCard demonstrates local setState inside a widget.
class LocalCounterCard extends StatefulWidget {
  const LocalCounterCard({Key? key}) : super(key: key);

  @override
  State<LocalCounterCard> createState() => _LocalCounterCardState();
}

class _LocalCounterCardState extends State<LocalCounterCard> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    // This widget manages its own internal state via setState.
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => setState(() => _count--),
        ),
        Text('$_count', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => setState(() => _count++),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () => setState(() => _count = 0),
          child: const Text('Reset'),
        ),
      ],
    );
  }
}

// Child used in "lifting state up" example. This child is stateless and receives
// callbacks from its parent to change the parent's state.
class LiftingChild extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  const LiftingChild({
    Key? key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  }) : super(key: key);

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

// Deep child that depends on CounterInherited and updates it.
class DeepInheritedChild extends StatelessWidget {
  const DeepInheritedChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the shared notifier from the nearest CounterInherited in the tree.
    final notifier = CounterInherited.of(context);

    // Use ValueListenableBuilder to rebuild only this part when the inherited value changes.
    return ValueListenableBuilder<int>(
      valueListenable: notifier,
      builder: (context, value, _) {
        return Row(
          children: [
            Text('Inherited counter: ', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 6),
            Text('$value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => notifier.value = notifier.value + 1,
              tooltip: 'Increment via inherited notifier',
            ),
          ],
        );
      },
    );
  }
}

// A simple selection page which returns a String result to the caller via Navigator.pop.
class SelectionPage extends StatelessWidget {
  final String title;
  final List<String> options;

  const SelectionPage({Key? key, required this.title, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: options.length + 1,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index == options.length) {
            // A cancel option demonstrating popping without a meaningful result.
            return ListTile(
              title: const Text('Cancel', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.of(context).pop(null),
            );
          }
          final option = options[index];
          return ListTile(
            title: Text(option),
            onTap: () {
              // Return the selected option to the caller.
              Navigator.of(context).pop(option);
            },
          );
        },
      ),
    );
  }
}

/*
TIPS / EXPLANATION:

- Local setState: simple and effective when state only concerns a single, small widget.
- Lifting state up: move state to the nearest common ancestor when multiple children need to coordinate.
- ValueNotifier + ValueListenableBuilder: lightweight reactive pattern for small pieces of mutable state without
  needing a full state-management library. Remember to dispose the notifier when no longer needed.
- InheritedWidget / InheritedNotifier: useful to provide shared data down a widget subtree. Combine with ChangeNotifier
  (or ValueNotifier) to trigger rebuilds. Use sparingly and prefer a stable API layer around the raw inherited type.
- Navigation: pass arguments via constructor or Route settings; await results from push to receive data when the pushed
  page pops. Remember that returned results can be null, so handle cancellations.

Next steps (external packages — only mention here for learning):
Consider Provider, Bloc, Riverpod, or other patterns for larger apps — they build on these primitives to provide testable,
scalable architectures.
*/