import 'dart:async';
import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:flutter/material.dart';

class SortingController extends ChangeNotifier implements VisualController {
  bool _disposed = false;

  @override
  void dispose() {
    stop();
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  // variable
  List<int> list = [5, 3, 1, 6, 7, 2, 4, 9, 8];
  @override
  double speed = 1.0;
  double size = 24;
  static const int baseDurationMs = 300;
  Completer<void>? _pauseCompleter;
  int currentSteps = 0;
  List<SortStep> steps = [];
  @override
  List<SortItem> items = [];
  int currentStepIndex = 0;
  bool isManualMode = false;
  int highlightedLine = -1;
  String currentExplanation = "Press Sort to start";
  //boolean controller

  @override
  bool isSorting = false;
  @override
  bool isStarted = false;
  @override
  bool isPlaying = false;
  bool isStopped = false;
  Timer? visualizationTimer;

  SortingController() {
    reset();
  }

  // methods

  // timing
  @override
  Duration get animDuration {
    final ms = (baseDurationMs / speed).round();
    return Duration(milliseconds: ms.clamp(16, 1000));
  }

  Duration delay() {
    final ms = (baseDurationMs / speed).round();
    return Duration(milliseconds: ms.clamp(16, 1000));
  }

  Future<void> _waitIfPaused() async {
    while (!_disposed && !isPlaying) {
      _pauseCompleter ??= Completer<void>();
      await _pauseCompleter!.future;
    }
  }

  @override
  void reset() {
    isSorting = false;
    isStarted = false;
    isPlaying = false;
    _pauseCompleter = null;
    items = list.map((e) => SortItem(e)).toList();
    currentExplanation = "Press Sort to start";
    notifyListeners();
  }

  //start sort
  @override
  Future<void> start(Algo algo) async {
    if (algo is! SortingAlgorithm) {
      throw ArgumentError("Invalid algorithm passed to SortingController");
    }
    if (isSorting) {
      return;
    }

    isSorting = true;
    isPlaying = true;
    isStarted = true;
    isStopped = false;
    isManualMode = false;
    currentStepIndex = -1;
    steps.clear();
    currentExplanation = "Starting ${algo.name}";
    notifyListeners();

    try {
      await algo.sort(
        items,
        () async {
          await _waitIfPaused();
          _record(currentExplanation);
          notifyListeners();
          await Future.delayed(delay());
        },
        delay(),
        (text) {
          currentExplanation = text;
          notifyListeners();
        },
      );
      currentExplanation = "Sorting completed";
    } catch (_) {
    } finally {
      isSorting = false;
      isPlaying = false;
      isManualMode = true;
      _enterManualMode();
      notifyListeners();
    }
  }

  @override
  void pause() {
    if (!isSorting) return;
    _enterManualMode();
    isPlaying = false;
    isManualMode = true;
    notifyListeners();
  }

  void stop() {
    isStopped = true;
    isSorting = false;
    isPlaying = false;

    _pauseCompleter?.complete();
    _pauseCompleter = null;
  }

  @override
  void play() {
    if (!isSorting) return;
    isPlaying = true;
    isManualMode = false;
    _pauseCompleter?.complete();
    _pauseCompleter = null;
    notifyListeners();
  }

  void _record(String exp) {
    steps.add(
      SortStep(
        items.map((e) => SortItem(e.value, isActive: e.isActive)).toList(),
        exp,
      ),
    );
  }

  void enterManualMode() {
    if (steps.isEmpty) return;

    isManualMode = true;
    isPlaying = false;
  }

  void nextStep() {
    //if (!isManualMode) return;
    if (steps.isEmpty) return;
    _enterManualMode();
    if (currentStepIndex >= steps.length - 1) return;

    currentStepIndex++;

    final step = steps[currentStepIndex];
    items =
        step.snapshot
            .map((e) => SortItem(e.value, isActive: e.isActive))
            .toList();

    currentExplanation = step.explanation;
    notifyListeners();
  }

  void previousStep() {
    if (steps.isEmpty) return;
    _enterManualMode();
    // if (!isManualMode) return;
    if (currentStepIndex <= 0) return;

    currentStepIndex--;

    final step = steps[currentStepIndex];
    items =
        step.snapshot
            .map((e) => SortItem(e.value, isActive: e.isActive))
            .toList();

    currentExplanation = step.explanation;
    notifyListeners();
  }

  void _enterManualMode() {
    isPlaying = false;
    isManualMode = true;
    _pauseCompleter ??= Completer<void>();
    notifyListeners();
  }

  @override
  String get type => "Sort";
}
