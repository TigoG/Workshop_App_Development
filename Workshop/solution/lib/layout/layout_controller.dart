// LayoutController: simple controller for the layout demo.
// Manages mode, gap and debug flag and computes effective mode by width.

import 'package:flutter/material.dart';

enum LayoutMode { auto, single, twoColumn, grid }

class LayoutController extends ChangeNotifier {
  LayoutMode _mode = LayoutMode.auto;
  double _gap = 12.0;
  bool _showDebug = false;

  static const double breakpoint = 600.0;

  // Getters
  LayoutMode get mode => _mode;
  double get gap => _gap;
  bool get showDebug => _showDebug;

  // Setters with notification
  void setMode(LayoutMode m) {
    if (_mode == m) return;
    _mode = m;
    notifyListeners();
  }

  void setGap(double value) {
    if (_gap == value) return;
    _gap = value;
    notifyListeners();
  }

  void toggleShowDebug() {
    _showDebug = !_showDebug;
    notifyListeners();
  }

  /// Compute effective mode based on current mode and available width.
  LayoutMode effectiveModeForWidth(double width) {
    if (_mode == LayoutMode.auto) {
      return width < breakpoint ? LayoutMode.single : LayoutMode.twoColumn;
    }
    return _mode;
  }

  /// Helper to reset to default values.
  void reset() {
    _mode = LayoutMode.auto;
    _gap = 12.0;
    _showDebug = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}