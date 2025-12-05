import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workshop_solution/state/state_page.dart';

void main() {
  group('State page widget tests', () {
    testWidgets('LocalCounterRefactor increments, decrements and resets', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: LocalCounterRefactor())));

      // initial value
      expect(find.text('0'), findsOneWidget);

      // increment
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      // decrement
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);

      // reset
      await tester.tap(find.text('Reset'));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('LiftingChildRefactor calls callbacks', (WidgetTester tester) async {
      var incCalled = false;
      var decCalled = false;
      var resetCalled = false;
      const value = 7;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: LiftingChildRefactor(
            value: value,
            onIncrement: () => incCalled = true,
            onDecrement: () => decCalled = true,
            onReset: () => resetCalled = true,
          ),
        ),
      ));

      expect(find.text('7'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(incCalled, isTrue);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(decCalled, isTrue);

      await tester.tap(find.text('Reset'));
      await tester.pump();
      expect(resetCalled, isTrue);
    });

    testWidgets('DeepInheritedChildRefactor reacts to notifier changes', (WidgetTester tester) async {
      final notifier = ValueNotifier<int>(0);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CounterInherited(notifier: notifier, child: const DeepInheritedChildRefactor()),
        ),
      ));

      final deep = find.byType(DeepInheritedChildRefactor);

      // initial value shown
      expect(find.descendant(of: deep, matching: find.text('0')), findsOneWidget);

      // tap increment icon inside deep child
      await tester.tap(find.byIcon(Icons.add_circle_outline));
      await tester.pump();

      expect(find.descendant(of: deep, matching: find.text('1')), findsOneWidget);
    });
  });
}