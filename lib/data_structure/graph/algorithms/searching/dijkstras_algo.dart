import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class DijkstraAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.dijkstra;

  @override
  String get name => "Dijkstra Shortest Path";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return DijkstraGenerator.generate(graph, start);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.initialization, op: AlgoOp.initDistance),
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
    AlgoInstruction(
      phase: AlgoPhase.relaxation,
      op: AlgoOp.initParent,
      target: "v",
      args: {"parent": "u"},
    ),
  ];
}

class DijkstraGenerator {
  static List<GraphStep> generate(GraphModel graph, String startId) {
    final steps = <GraphStep>[];

    // ---- runtime state ----
    final distances = <String, double>{};
    final settled = <String>{};
    final parents = <String, String?>{};
    final pq = <String>[]; // priority queue (min dist)

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    // ---- init ----
    for (final id in nodes.keys) {
      distances[id] = double.infinity;
      parents[id] = null;
    }

    distances[startId] = 0;
    pq.add(startId);

    nodes = {
      ...nodes,
      startId: nodes[startId]!.copyWith(
        state: NodeState.discovered,
        meta: {'distance': 0},
      ),
    };

    steps.add(
      _step(
        nodes,
        edges,
        pq,
        parents,
        AlgoPhase.initialization,
        active: startId,
      ),
    );

    // ---- main loop ----
    while (pq.isNotEmpty) {
      // extract min-distance node
      pq.sort((a, b) => distances[a]!.compareTo(distances[b]!));
      final u = pq.removeAt(0);

      if (settled.contains(u)) continue;
      settled.add(u);

      // 1️⃣ mark current
      nodes = {...nodes, u: nodes[u]!.copyWith(state: NodeState.current)};
      steps.add(
        _step(nodes, edges, pq, parents, AlgoPhase.exploration, active: u),
      );

      // 2️⃣ relax edges
      for (final edge in graph.incidentEdges(u)) {
        final v = edge.from == u ? edge.to : edge.from;
        if (settled.contains(v)) continue;

        final alt = distances[u]! + edge.weight;
        if (alt < distances[v]!) {
          distances[v] = alt;
          parents[v] = u;

          nodes = {
            ...nodes,
            v: nodes[v]!.copyWith(
              state: NodeState.discovered,
              meta: {'distance': alt},
            ),
          };

          edges = {
            ...edges,
            edge.id: edge.copyWith(state: EdgeState.exploring),
          };

          if (!pq.contains(v)) pq.add(v);

          steps.add(
            _step(nodes, edges, pq, parents, AlgoPhase.exploration, active: u),
          );
        }
      }

      // 3️⃣ settle node
      nodes = {...nodes, u: nodes[u]!.copyWith(state: NodeState.visited)};
      steps.add(
        _step(nodes, edges, pq, parents, AlgoPhase.completion, active: null),
      );
    }

    return steps;
  }

  // ---- helper ----
  static GraphStep _step(
    Map<String, NodeModel> nodes,
    Map<String, EdgeModel> edges,
    List<String> pq,
    Map<String, String?> parents,
    AlgoPhase pase, {
    required String? active,
  }) {
    return GraphStep(
      phase: pase,
      activeNodeId: active,
      nodes: Map.from(nodes),
      edges: Map.from(edges),
      frontier: List.from(pq),
      parents: Map.from(parents),
    );
  }
}
