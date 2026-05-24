import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class KruskalAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.kruskal;

  @override
  String get name => "Kruskal's Minimum Spanning Tree";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return KruskalGenerator.generate(graph);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.unionFind, op: AlgoOp.initDisjointSet),
    AlgoInstruction(
      phase: AlgoPhase.unionFind,
      op: AlgoOp.findSet,
      target: "u",
    ),
    AlgoInstruction(
      phase: AlgoPhase.unionFind,
      op: AlgoOp.unionSet,
      args: {"u": "u", "v": "v"},
    ),
  ];
}

class KruskalGenerator {
  static List<GraphStep> generate(GraphModel graph) {
    final steps = <GraphStep>[];

    final parent = <String, String>{};

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    String find(String x) {
      if (parent[x] == x) return x;
      return parent[x] = find(parent[x]!);
    }

    void union(String a, String b) {
      parent[find(a)] = find(b);
    }

    for (final n in nodes.keys) {
      parent[n] = n;
    }

    final sortedEdges =
        edges.values.toList()..sort((a, b) => a.weight.compareTo(b.weight));

    for (final edge in sortedEdges) {
      final u = edge.from;
      final v = edge.to;

      edges[edge.id] = edge.copyWith(state: EdgeState.exploring);

      steps.add(_step(nodes, edges, [], {}, null, AlgoPhase.initialization));

      if (find(u) != find(v)) {
        union(u, v);
        edges[edge.id] = edge.copyWith(state: EdgeState.selected);
        steps.add(_step(nodes, edges, [], {}, null, AlgoPhase.exploration));
      }
    }

    return steps;
  }

  static GraphStep _step(
    Map<String, NodeModel> nodes,
    Map<String, EdgeModel> edges,
    List<String> frontier,
    Map<String, String?> parents,
    String? active,
    AlgoPhase pase,
  ) => GraphStep(
    phase: pase,
    activeNodeId: active,
    nodes: Map.from(nodes),
    edges: Map.from(edges),
    frontier: frontier,
    parents: parents,
  );
}
