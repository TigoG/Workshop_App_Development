import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workshop_solution/state/state_controller.dart';

void main() {
  group('StateController unit tests', () {
    late StateController controller;

    setUp(() {
      controller = StateController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('initial values', () {
      expect(controller.liftedCounter, 0);
      expect(controller.valueNotifier, isNotNull);
      expect(controller.valueNotifier!.value, 0);
      expect(controller.inheritedCounter.value, 0);
      expect(controller.navResult, 'No result yet');
    });

    test('lifted counter API', () {
      controller.incrementLifted();
      expect(controller.liftedCounter, 1);
      controller.incrementLifted();
      expect(controller.liftedCounter, 2);
      controller.decrementLifted();
      expect(controller.liftedCounter, 1);
      controller.resetLifted();
      expect(controller.liftedCounter, 0);
    });

    test('valueNotifier lifecycle and API', () {
      controller.incrementValueNotifier();
      expect(controller.valueNotifier!.value, 1);
      controller.decrementValueNotifier();
      expect(controller.valueNotifier!.value, 0);
      controller.resetValueNotifier();
      expect(controller.valueNotifier!.value, 0);
      // dispose the notifier
      controller.disposeValueNotifier();
      expect(controller.valueNotifier, isNull);
      // recreate
      controller.recreateValueNotifier();
      expect(controller.valueNotifier, isNotNull);
      expect(controller.valueNotifier!.value, 0);
    });

    test('inherited notifier API', () {
      controller.incrementInherited();
      expect(controller.inheritedCounter.value, 1);
      controller.decrementInherited();
      expect(controller.inheritedCounter.value, 0);
      controller.resetInherited();
      expect(controller.inheritedCounter.value, 0);
    });

    test('navigation result & resetAll', () {
      controller.setNavResult('Test');
      expect(controller.navResult, 'Test');
      controller.resetAll();
      expect(controller.liftedCounter, 0);
      expect(controller.valueNotifier!.value, 0);
      expect(controller.inheritedCounter.value, 0);
      expect(controller.navResult, 'No result yet');
    });
  });
}