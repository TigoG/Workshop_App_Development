// StateController: centralizes state examples used by the State demo page.
//
// Responsibilities:
// - Provide lifted counter API (increment/decrement/reset).
// - Own a ValueNotifier<int> for the ValueListenable example (create/dispose).
// - Provide an inherited ValueNotifier for the InheritedWidget example.
// - Hold a navigation result string that the UI can update/display.
//
// The controller is a ChangeNotifier so the page UI can listen for structural changes
// (e.g., lifted counter or notifier recreated/disposed).
import 'package:flutter/material.dart';

class StateController extends ChangeNotifier {
  // Lifted counter (parent-owned state)
  int _liftedCounter = 0;

  // ValueNotifier example (can be recreated/disposed to demonstrate lifecycle).
  ValueNotifier<int>? _valueNotifier;

  // InheritedNotifier example (shared via Inherited widget).
  final ValueNotifier<int> inheritedNotifier = ValueNotifier<int>(0);

  // Navigation result (simple string for the demo).
  String _navResult = 'No result yet';

  // Constructor initializes the ValueNotifier for the demo.
  StateController() {
    _valueNotifier = ValueNotifier<int>(0);
  }

  // --- Getters ---
  int get liftedCounter => _liftedCounter;
  ValueNotifier<int>? get valueNotifier => _valueNotifier;
  ValueNotifier<int> get inheritedCounter => inheritedNotifier;
  String get navResult => _navResult;

  // --- Lifted counter API ---
  void incrementLifted() {
    _liftedCounter++;
    notifyListeners();
  }

  void decrementLifted() {
    _liftedCounter--;
    notifyListeners();
  }

  void resetLifted() {
    _liftedCounter = 0;
    notifyListeners();
  }

  // --- ValueNotifier management ---
  /// Recreate the value notifier if it was disposed.
  void recreateValueNotifier() {
    if (_valueNotifier == null) {
      _valueNotifier = ValueNotifier<int>(0);
      notifyListeners();
    }
  }

  /// Dispose the ValueNotifier to demonstrate lifecycle / cleanup.
  void disposeValueNotifier() {
    _valueNotifier?.dispose();
    _valueNotifier = null;
    notifyListeners();
  }

  /// Convenience helpers to mutate the notifier's value (no notifyListeners needed;
  /// ValueListenableBuilder will rebuild the small UI piece).
  void incrementValueNotifier() {
    if (_valueNotifier != null) _valueNotifier!.value++;
  }

  void decrementValueNotifier() {
    if (_valueNotifier != null) _valueNotifier!.value--;
  }

  void resetValueNotifier() {
    if (_valueNotifier != null) _valueNotifier!.value = 0;
  }

  // --- InheritedNotifier API ---
  void incrementInherited() => inheritedNotifier.value++;
  void decrementInherited() => inheritedNotifier.value--;
  void resetInherited() => inheritedNotifier.value = 0;

  // --- Navigation result ---
  void setNavResult(String result) {
    _navResult = result;
    notifyListeners();
  }

  // --- Helpers / lifecycle ---
  /// Reset all demo state back to defaults.
  void resetAll() {
    _liftedCounter = 0;
    _valueNotifier?.dispose();
    _valueNotifier = ValueNotifier<int>(0);
    inheritedNotifier.value = 0;
    _navResult = 'No result yet';
    notifyListeners();
  }

  @override
  void dispose() {
    _valueNotifier?.dispose();
    inheritedNotifier.dispose();
    super.dispose();
  }
}