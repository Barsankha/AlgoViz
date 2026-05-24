import 'dart:async';
import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:flutter/material.dart';

/////////
///
///
///
///
class GraphController extends ChangeNotifier implements VisualController {
  final GraphAlgoSteps _algoSteps;
  final Map<GraphAlgoType, GraphAlgorithm> _algorithms;

  @override
  String get type => "Graph";

  @override
  bool get isSorting => _isSorting;

  @override
  bool get isStarted => _steps.isNotEmpty;

  @override
  bool get isPlaying => _isPlaying;

  @override
  List get items => const [];

  @override
  double speed = 1.0;

  @override
  Duration get animDuration {
    final ms = (baseDurationMs / speed).round();
    return Duration(milliseconds: ms.clamp(16, 1000));
  }

  static const int baseDurationMs = 800;

  GraphStep? _initialStep;

  List<GraphStep> _steps = [];
  int index = 0;

  //List<GraphStep> get steps => _steps;
  //GraphStep? get currentStep =>
  //_steps.isEmpty ? null : _steps[_index];

  bool _isPlaying = false;
  bool _isSorting = false;
  bool _isStarted = false;

  Timer? _timer; //

  GraphController({
    required GraphAlgoSteps algoSteps,
    required GraphAlgorithm algorithms,
    required GraphModel graph,
  }) : _algoSteps = algoSteps,
       _algorithms = {algorithms.type: algorithms};

  // ---------------- Play with Algorithm ----------------

  @override
  Future<void> start(Algo algorithm) async {
    reset();
    play();
  }

  void startAlgorithm(
    GraphAlgoType type, {
    required GraphModel graph,
    required String startNodeId,
  }) {
    // 1️⃣ Already playing → pause
    if (_isPlaying) {
      pause();
      return;
    }

    // 2️⃣ Load steps ONLY ONCE
    if (!_algoSteps.has(type)) {
      final algo = _algorithms[type];
      if (algo == null) {
        throw Exception('Algorithm not registered: $type');
      }

      final steps = algo.generate(graph, startNodeId);
      if (steps.isEmpty) return;

      _algoSteps.register(type, steps);
    }

    // 3️⃣ Switch algorithm context
    _steps = _algoSteps.get(type);

    // ❗ DO NOT reset index if resuming
    if (!_isStarted) {
      index = 0;
      _isStarted = true;
    }

    // 4️⃣ Play
    _isPlaying = true;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _isPlaying = true;
    _isSorting = true;
    notifyListeners();

    _timer = Timer.periodic(animDuration, (_) {
      if (index >= _steps.length - 1) {
        pause();
        return;
      }
      index++;
      notifyListeners();
    });
  }

  // ---------------- Controls ----------------

  @override
  void pause() {
    _timer?.cancel();
    // _timer = null;
    _isPlaying = false;
    _isSorting = false;
    notifyListeners();
  }

  @override
  void reset() {
    _timer?.cancel();
    _isSorting = false;
    _isPlaying = false;
    pause();
    // _steps = [];
    index = 0;
    notifyListeners();
  }

  GraphStep get currentStep {
    if (_steps.isNotEmpty) {
      return _steps[index.clamp(0, _steps.length - 1)];
    }
    if (_initialStep != null) {
      return _initialStep!;
    }
    throw StateError('GraphController not initialized');
  }

  @override
  void play() {}

  void next() {
    pause();
    if (_steps.isEmpty) return;

    if (index < _steps.length - 1) {
      index++;
      notifyListeners();
    }
  }

  void previous() {
    pause();
    if (_steps.isEmpty) return;

    if (index > 0) {
      index--;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void initWithGraph(GraphModel graph) {
    _timer?.cancel();
    _isPlaying = false;

    _steps.clear();
    index = 0;

    _initialStep = GraphStep(
      activeNodeId: null,
      nodes: graph.nodes.map(
        (k, v) => MapEntry(k, v.copyWith(state: NodeState.unvisited)),
      ),
      edges: graph.edges,
      frontier: const [],
      parents: const {},
      phase: AlgoPhase.initialization,
      // meta: const {},
    );

    notifyListeners();
  }

  void loadSteps(List<GraphStep> steps) {
    _timer?.cancel();
    _isPlaying = false;

    _steps
      ..clear()
      ..addAll(steps);

    index = 0;
    notifyListeners();
  }

  void ok(Duration speed) {
    if (_isPlaying || _steps.isEmpty) return;

    _isPlaying = true;
    notifyListeners();

    _timer = Timer.periodic(speed, (_) {
      if (index >= _steps.length - 1) {
        pause();
        return;
      }
      next();
    });
  }
}
