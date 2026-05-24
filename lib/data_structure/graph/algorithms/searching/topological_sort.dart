import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class TopologicalSortAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.topologicalSort;

  @override
  String get name => "Topological Sort";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return TopologicalSortGenerator.generate(graph);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.initialization, op: AlgoOp.initIndegree),
    AlgoInstruction(
      phase: AlgoPhase.exploration,
      op: AlgoOp.enqueue,
      target: "zero-indegree nodes",
    ),
    AlgoInstruction(
      phase: AlgoPhase.exploration,
      op: AlgoOp.dequeue,
      target: "u",
    ),
    AlgoInstruction(
      phase: AlgoPhase.exploration,
      op: AlgoOp.exploreEdge,
      args: {"from": "u", "to": "v"},
    ),
  ];
}

class TopologicalSortGenerator {
  static List<GraphStep> generate(GraphModel graph) {
    final steps = <GraphStep>[];

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    final inDegree = <String, int>{};
    final queue = <String>[];
    final order = <String>[];

    // Init indegree
    for (final id in nodes.keys) {
      inDegree[id] = 0;
    }

    for (final e in edges.values) {
      inDegree[e.to] = inDegree[e.to]! + 1;
    }

    // Push zero indegree nodes
    for (final id in nodes.keys) {
      if (inDegree[id] == 0) {
        queue.add(id);
        nodes[id] = nodes[id]!.copyWith(state: NodeState.discovered);
      }
    }

    steps.add(_step(nodes, edges, queue, null, AlgoPhase.initialization));

    while (queue.isNotEmpty) {
      final u = queue.removeAt(0);
      order.add(u);

      nodes[u] = nodes[u]!.copyWith(state: NodeState.current);
      steps.add(_step(nodes, edges, queue, u, AlgoPhase.exploration));

      for (final e in graph.outgoingEdges(u)) {
        final v = e.to;

        edges[e.id] = e.copyWith(state: EdgeState.exploring);

        inDegree[v] = inDegree[v]! - 1;

        if (inDegree[v] == 0) {
          queue.add(v);
          nodes[v] = nodes[v]!.copyWith(state: NodeState.discovered);
        }

        steps.add(_step(nodes, edges, queue, u, AlgoPhase.exploration));
      }

      nodes[u] = nodes[u]!.copyWith(state: NodeState.visited);
      steps.add(_step(nodes, edges, queue, null, AlgoPhase.completion));
    }

    return steps;
  }

  static GraphStep _step(
    Map<String, NodeModel> nodes,
    Map<String, EdgeModel> edges,
    List<String> frontier,
    String? active,
    AlgoPhase pase,
  ) => GraphStep(
    phase: pase,
    activeNodeId: active,
    nodes: Map.from(nodes),
    edges: Map.from(edges),
    frontier: List.from(frontier),
    parents: {},
  );
}
