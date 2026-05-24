import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';

class GraphAlgoSteps {
  final Map<dynamic, List<GraphStep>> _steps = {};

  void register(dynamic type, List<GraphStep> steps) {
    _steps[type] = steps;
  }

  List<GraphStep> get(dynamic type) {
    final s = _steps[type];
    if (s == null || s.isEmpty) {
      throw Exception('No steps registered for $type');
    }
    return s;
  }

  bool has(dynamic type) => _steps.containsKey(type);
  //
  void clear() => _steps.clear();
}

class GraphStep {
  final String? activeNodeId;

  final Map<String, NodeModel> nodes;
  final Map<String, EdgeModel> edges;

  /// Queue / Stack / PriorityQueue visualization
  final List<String> frontier;

  /// Parent map for path reconstruction
  final Map<String, String?> parents;

  /// Explanation text
  final String message;

  final AlgoPhase phase;

  final Map<String, Map<String, double>>? distanceMatrix;

  final List<String>? result;

  final String? i;
  final String? j;
  final String? k;

  const GraphStep({
    this.activeNodeId,
    required this.nodes,
    required this.edges,
    required this.phase,
    this.frontier = const [],
    this.parents = const {},
    this.message = '',
    this.distanceMatrix = const {},
    this.i = '',
    this.j = '',
    this.k = '',
    this.result = const [],
  });
}
