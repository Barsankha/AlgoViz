import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class PrimAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.prims;

  @override
  String get name => "Prim's Minimum Spanning Tree";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return PrimGenerator.generate(graph, start);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(
      phase: AlgoPhase.selection,
      op: AlgoOp.selectMin,
      target: "u",
    ),
    AlgoInstruction(
      phase: AlgoPhase.relaxation,
      op: AlgoOp.relaxEdge,
      args: {"from": "u", "to": "v"},
    ),
  ];
}

class PrimGenerator {
  static List<GraphStep> generate(GraphModel graph, String startId) {
    final steps = <GraphStep>[];

    final inMST = <String>{};
    final parents = <String, String?>{};
    final pq = <String>[]; // min key
    final key = <String, double>{};

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    for (final id in nodes.keys) {
      key[id] = double.infinity;
      parents[id] = null;
    }

    key[startId] = 0;
    pq.add(startId);

    nodes[startId] = nodes[startId]!.copyWith(state: NodeState.discovered);

    steps.add(
      _step(nodes, edges, pq, parents, startId, AlgoPhase.initialization),
    );

    while (pq.isNotEmpty) {
      pq.sort((a, b) => key[a]!.compareTo(key[b]!));
      final u = pq.removeAt(0);

      if (inMST.contains(u)) continue;
      inMST.add(u);

      nodes[u] = nodes[u]!.copyWith(state: NodeState.current);
      steps.add(_step(nodes, edges, pq, parents, u, AlgoPhase.exploration));

      for (final edge in graph.incidentEdges(u)) {
        final v = edge.from == u ? edge.to : edge.from;
        if (inMST.contains(v)) continue;

        if (edge.weight < key[v]!) {
          key[v] = edge.weight;
          parents[v] = u;

          edges[edge.id] = edge.copyWith(state: EdgeState.selected);

          nodes[v] = nodes[v]!.copyWith(state: NodeState.discovered);

          if (!pq.contains(v)) pq.add(v);

          steps.add(_step(nodes, edges, pq, parents, u, AlgoPhase.exploration));
        }
      }

      nodes[u] = nodes[u]!.copyWith(state: NodeState.visited);
      steps.add(_step(nodes, edges, pq, parents, null, AlgoPhase.completion));
    }

    return steps;
  }

  static GraphStep _step(
    Map<String, NodeModel> nodes,
    Map<String, EdgeModel> edges,
    List<String> pq,
    Map<String, String?> parents,
    String? active,
    AlgoPhase pase,
  ) => GraphStep(
    phase: pase,
    activeNodeId: active,
    nodes: Map.from(nodes),
    edges: Map.from(edges),
    frontier: List.from(pq),
    parents: Map.from(parents),
  );
}
