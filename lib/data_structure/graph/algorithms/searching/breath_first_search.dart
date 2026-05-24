import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class BFSAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.breathFirstSearch;

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return BFSGenerator.generate(graph, start);
  }

  @override
  String get name => "Breath First search";

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.initialization, op: AlgoOp.initVisited),
    AlgoInstruction(
      phase: AlgoPhase.initialization,
      op: AlgoOp.enqueue,
      target: "start",
    ),
    AlgoInstruction(
      phase: AlgoPhase.exploration,
      op: AlgoOp.dequeue,
      target: "u",
    ),
    AlgoInstruction(
      phase: AlgoPhase.exploration,
      op: AlgoOp.visitNode,
      target: "u",
    ),
    AlgoInstruction(
      phase: AlgoPhase.exploration,
      op: AlgoOp.exploreEdge,
      args: {"from": "u", "to": "v"},
    ),
    AlgoInstruction(
      phase: AlgoPhase.exploration,
      op: AlgoOp.enqueue,
      target: "v",
    ),
  ];
}

class BFSGenerator {
  static List<GraphStep> generate(GraphModel graph, String startId) {
    final steps = <GraphStep>[];

    // ---- runtime state (DO NOT expose directly) ----
    final visited = <String>{};
    final queue = <String>[];
    final parents = <String, String?>{};

    Map<String, NodeModel> nodes = Map.fromEntries(graph.nodes.entries);
    Map<String, EdgeModel> edges = Map.fromEntries(graph.edges.entries);

    // ---- init ----
    visited.add(startId);
    queue.add(startId);
    parents[startId] = null;

    nodes = {
      ...nodes,
      startId: nodes[startId]!.copyWith(state: NodeState.discovered),
    };

    steps.add(
      _step(
        nodes,
        edges,
        queue,
        parents,
        active: startId,
        pase: AlgoPhase.initialization,
      ),
    );

    // ---- BFS loop ----
    while (queue.isNotEmpty) {
      final u = queue.removeAt(0);

      // 1️⃣ mark current
      nodes = {...nodes, u: nodes[u]!.copyWith(state: NodeState.current)};

      steps.add(
        _step(
          nodes,
          edges,
          queue,
          parents,
          active: u,
          pase: AlgoPhase.exploration,
        ),
      );

      // 2️⃣ explore neighbors
      for (final edge in graph.incidentEdges(u)) {
        final v = edge.from == u ? edge.to : edge.from;

        if (visited.contains(v)) continue;

        visited.add(v);
        parents[v] = u;
        queue.add(v);

        nodes = {...nodes, v: nodes[v]!.copyWith(state: NodeState.discovered)};

        edges = {...edges, edge.id: edge.copyWith(state: EdgeState.exploring)};

        steps.add(
          _step(
            nodes,
            edges,
            queue,
            parents,
            active: u,
            pase: AlgoPhase.exploration,
          ),
        );
      }

      // 3️⃣ mark visited
      nodes = {...nodes, u: nodes[u]!.copyWith(state: NodeState.visited)};

      steps.add(
        _step(
          nodes,
          edges,
          queue,
          parents,
          active: null,
          pase: AlgoPhase.completion,
        ),
      );
    }

    return steps;
  }

  // ---- helper ----
  static GraphStep _step(
    Map<String, NodeModel> nodes,
    Map<String, EdgeModel> edges,
    List<String> queue,
    Map<String, String?> parents, {
    required String? active,
    required AlgoPhase pase,
  }) {
    return GraphStep(
      phase: pase,
      activeNodeId: active,
      nodes: Map.from(nodes),
      edges: Map.from(edges),
      frontier: List.from(queue),
      parents: Map.from(parents),
    );
  }
}
