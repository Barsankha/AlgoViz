import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class AStarAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.aStar;

  @override
  String get name => "A* Search";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return AStarGenerator.generate(graph, start);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.stackPhase, op: AlgoOp.pushStack),
    AlgoInstruction(phase: AlgoPhase.stackPhase, op: AlgoOp.popStack),
    AlgoInstruction(phase: AlgoPhase.completion, op: AlgoOp.outputResult),
  ];
}

class AStarGenerator {
  static List<GraphStep> generate(GraphModel graph, String startId) {
    final steps = <GraphStep>[];

    double h(String a, String b) {
      final p1 = graph.nodes[a]!.position;
      final p2 = graph.nodes[b]!.position;
      return (p1 - p2).distance;
    }

    final g = <String, double>{};
    final parents = <String, String?>{};
    final open = <String>{};

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    for (final id in nodes.keys) {
      g[id] = double.infinity;
      parents[id] = null;
    }

    g[startId] = 0;
    open.add(startId);

    while (open.isNotEmpty) {
      final u = open.reduce(
        (a, b) => g[a]! + h(a, startId) < g[b]! + h(b, startId) ? a : b,
      );

      open.remove(u);
      nodes[u] = nodes[u]!.copyWith(state: NodeState.current);
      steps.add(
        _step(
          nodes,
          edges,
          open.toList(),
          parents,
          u,
          AlgoPhase.initialization,
        ),
      );

      for (final edge in graph.incidentEdges(u)) {
        final v = edge.from == u ? edge.to : edge.from;
        final alt = g[u]! + edge.weight;

        if (alt < g[v]!) {
          g[v] = alt;
          parents[v] = u;
          open.add(v);

          nodes[v] = nodes[v]!.copyWith(state: NodeState.discovered);
          edges[edge.id] = edge.copyWith(state: EdgeState.exploring);

          steps.add(
            _step(
              nodes,
              edges,
              open.toList(),
              parents,
              u,
              AlgoPhase.exploration,
            ),
          );
        }
      }

      nodes[u] = nodes[u]!.copyWith(state: NodeState.visited);
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
