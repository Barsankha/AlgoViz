import 'dart:async';
import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:flutter/material.dart';

class SearchAlgoController extends ChangeNotifier implements VisualController {
  @override
  List<SearchItem> items = [];

  int target = 7;

  List<int> list = [5, 3, 1, 6, 7, 2, 4, 9, 8];

  void updateTarget(int v) {
    target = v;
    notifyListeners();
  }

  void updatelist(List<int> list) {
    list = list..sort();
    notifyListeners();
  }

  void updatelistD(List<int> list) {
    list = list..sort((a, b) => b.compareTo(a));
    notifyListeners();
  }

  int _currentIndex = -1;
  @override
  bool isStarted = false;
  @override
  bool isSorting = true; // reuse flag
  @override
  @override
  Duration get animDuration {
    final ms = (baseDurationMs / speed).round();
    return Duration(milliseconds: ms.clamp(16, 1000));
  }

  static const int baseDurationMs = 800;

  bool isSortedA = false;
  bool isSortedD = false;

  Timer? _timer;
  @override
  bool isPlaying = false;
  bool isfound = false;

  // SearchAlgoController({required List<int> list})
  //   : items = list.map((e) => SearchItem(value: e)).toList();
  SearchAlgoController() {
    reset();
  }
  /* ================= PLAY ================= */
  Future<void> sortA() async {
    updatelist(list);
    pause();
    reset();
    // await Future.delayed(const Duration(milliseconds: 100));
    notifyListeners();
  }

  Future<void> sortD() async {
    updatelistD(list);
    pause();
    reset();
    // await Future.delayed(const Duration(milliseconds: 100));
    notifyListeners();
  }

  @override
  void play() {
    if (isPlaying) return;
    isPlaying = true;
    isStarted = true;

    _timer = Timer.periodic(animDuration, (_) => _step());
    notifyListeners();
  }

  /* ================= STEP ================= */

  void _step() {
    if (_currentIndex >= 0 && _currentIndex < items.length) {
      items[_currentIndex].isActive = false;
    }

    _currentIndex++;

    if (_currentIndex >= items.length) {
      _finish(false);
      return;
    }

    items[_currentIndex].isActive = true;

    if (items[_currentIndex].value == target) {
      items[_currentIndex].isFound = true;
      _finish(true);
    }

    notifyListeners();
  }

  /* ================= PAUSE ================= */

  @override
  void pause() {
    _timer?.cancel();
    isPlaying = false;
    notifyListeners();
  }

  /* ================= NEXT ================= */

  void next() {
    if (!isPlaying) _step();
  }

  /* ================= RESET ================= */

  @override
  void reset() {
    //pause();
    _currentIndex = -1;
    isStarted = false;
    isSorting = true;

    for (final item in items) {
      item.isActive = false;
      item.isFound = false;
    }
    items = list.map((e) => SearchItem(value: e)).toList();
    notifyListeners();
  }

  /* ================= FINISH ================= */

  void _finish(bool found) {
    pause();
    isSorting = false;

    if (!found) {
      for (final item in items) {
        item.isActive = false;
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  String get type => "Search";

  @override
  double speed = 1.0;
  double size = 24;

  Future<void> restart(dynamic algo, int target) async {
    updateTarget(target);
    await start(algo);
    notifyListeners();
  }

  @override
  Future<void> start(Algo algorithm) async {
    if (algorithm is! SearchingAlgorithm) {
      throw ArgumentError("Invalid algorithm passed to SearchController");
    }

    // Reset state
    isStarted = true;
    isSorting = true;
    isPlaying = false;

    for (final item in items) {
      item.isActive = false;
      item.isFound = false;
    }

    notifyListeners();

    // Calculate delay from speed (same logic as sorting)
    final Duration delay = Duration(
      milliseconds: (600 ~/ speed).clamp(50, 2000),
    );

    try {
      await algorithm.search(
        items,
        () async {
          notifyListeners();
        },
        delay,
        this,
        target,
      );
    } finally {
      // Finished (found or not)
      isSorting = false;
      isPlaying = false;
      notifyListeners();
    }
  }
}
