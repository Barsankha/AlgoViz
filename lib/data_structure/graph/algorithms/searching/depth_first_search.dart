import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class DFSAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.depthFirstSearch;

  @override
  String get name => "Depth First Search";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return DFSGenerator.generate(graph, start);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.initialization, op: AlgoOp.initVisited),
    AlgoInstruction(
      phase: AlgoPhase.stackPhase,
      op: AlgoOp.pushStack,
      target: "start",
    ),
    AlgoInstruction(
      phase: AlgoPhase.stackPhase,
      op: AlgoOp.popStack,
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
      phase: AlgoPhase.stackPhase,
      op: AlgoOp.pushStack,
      target: "v",
    ),
  ];
}

class DFSGenerator {
  static List<GraphStep> generate(GraphModel graph, String startId) {
    final steps = <GraphStep>[];

    final visited = <String>{};
    final stack = <String>[];
    final parents = <String, String?>{};

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    // ---- init ----
    stack.add(startId);
    parents[startId] = null;

    nodes = {
      ...nodes,
      startId: nodes[startId]!.copyWith(state: NodeState.discovered),
    };

    steps.add(
      _step(
        nodes,
        edges,
        stack,
        parents,
        AlgoPhase.initialization,
        active: startId,
      ),
    );

    // ---- DFS loop ----
    while (stack.isNotEmpty) {
      final u = stack.removeLast();

      if (visited.contains(u)) continue;
      visited.add(u);

      // 1️⃣ mark current
      nodes = {...nodes, u: nodes[u]!.copyWith(state: NodeState.current)};
      steps.add(
        _step(nodes, edges, stack, parents, AlgoPhase.exploration, active: u),
      );

      // 2️⃣ push neighbors
      for (final edge in graph.incidentEdges(u).reversed) {
        final v = edge.from == u ? edge.to : edge.from;

        if (visited.contains(v)) continue;

        parents[v] = u;
        stack.add(v);

        nodes = {...nodes, v: nodes[v]!.copyWith(state: NodeState.discovered)};
        edges = {...edges, edge.id: edge.copyWith(state: EdgeState.exploring)};

        steps.add(
          _step(nodes, edges, stack, parents, AlgoPhase.exploration, active: u),
        );
      }

      // 3️⃣ mark visited
      nodes = {...nodes, u: nodes[u]!.copyWith(state: NodeState.visited)};
      steps.add(
        _step(nodes, edges, stack, parents, AlgoPhase.completion, active: null),
      );
    }

    return steps;
  }

  static GraphStep _step(
    Map<String, NodeModel> nodes,
    Map<String, EdgeModel> edges,
    List<String> stack,
    Map<String, String?> parents,
    AlgoPhase pase, {
    required String? active,
  }) {
    return GraphStep(
      phase: pase,
      activeNodeId: active,
      nodes: Map.from(nodes),
      edges: Map.from(edges),
      frontier: List.from(stack),
      parents: Map.from(parents),
    );
  }
}
