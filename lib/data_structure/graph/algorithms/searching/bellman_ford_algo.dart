import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class BellmanFordAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.bellManFord;

  @override
  String get name => "Bellman–Ford Shortest Path";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return BellmanFordGenerator.generate(graph, start);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.initialization, op: AlgoOp.initDistance),
    AlgoInstruction(
      phase: AlgoPhase.relaxation,
      op: AlgoOp.relaxEdge,
      args: {"from": "u", "to": "v"},
    ),
    AlgoInstruction(phase: AlgoPhase.completion, op: AlgoOp.outputResult),
  ];
}

class BellmanFordGenerator {
  static List<GraphStep> generate(GraphModel graph, String startId) {
    final steps = <GraphStep>[];

    final dist = <String, double>{};
    final parents = <String, String?>{};

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    for (final id in nodes.keys) {
      dist[id] = double.infinity;
      parents[id] = null;
    }

    dist[startId] = 0;
    nodes[startId] = nodes[startId]!.copyWith(meta: {'distance': 0});

    steps.add(
      _step(nodes, edges, [], parents, startId, AlgoPhase.initialization),
    );

    for (int i = 0; i < nodes.length - 1; i++) {
      for (final edge in edges.values) {
        final u = edge.from;
        final v = edge.to;

        final alt = dist[u]! + edge.weight;
        if (alt < dist[v]!) {
          dist[v] = alt;
          parents[v] = u;

          nodes[v] = nodes[v]!.copyWith(meta: {'distance': alt});
          edges[edge.id] = edge.copyWith(state: EdgeState.exploring);

          steps.add(_step(nodes, edges, [], parents, v, AlgoPhase.exploration));
        }
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
    parents: Map.from(parents),
  );
}
