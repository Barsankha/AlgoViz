import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

abstract class GraphAlgorithm implements Algo {
  @override
  String get name;

  GraphAlgoType get type;

  List<GraphStep> generate(GraphModel graph, String startNodeId);
}

class GraphModel {
  final Map<String, NodeModel> nodes;
  final Map<String, EdgeModel> edges;
  final bool directed;

  const GraphModel({
    required this.nodes,
    required this.edges,
    this.directed = false,
  });

  /// ---------------- Utilities ----------------
  GraphModel transpose() {
    final newEdges = <String, EdgeModel>{};

    for (final e in edges.values) {
      newEdges[e.id] = EdgeModel(
        id: e.id,
        from: e.to,
        to: e.from,
        weight: e.weight,
        state: e.state,
      );
    }

    return GraphModel(nodes: nodes, edges: newEdges, directed: directed);
  }

  List<String> neighborsOf(String nodeId) {
    final neighbors = <String>[];

    for (final e in edges.values) {
      if (e.from == nodeId) {
        neighbors.add(e.to);
      } else if (!e.directed && e.to == nodeId) {
        neighbors.add(e.from);
      }
    }
    return neighbors;
  }

  List<EdgeModel> outgoingEdges(String nodeId) {
    return edges.values.where((e) => e.from == nodeId).toList();
  }

  List<EdgeModel> incidentEdges(String nodeId) {
    return edges.values
        .where((e) => e.from == nodeId || (!e.directed && e.to == nodeId))
        .toList();
  }

  /// ---------------- Copy helpers ----------------

  GraphModel copyWith({
    Map<String, NodeModel>? nodes,
    Map<String, EdgeModel>? edges,
  }) {
    return GraphModel(
      nodes: nodes ?? this.nodes,
      edges: edges ?? this.edges,
      directed: directed,
    );
  }
}
