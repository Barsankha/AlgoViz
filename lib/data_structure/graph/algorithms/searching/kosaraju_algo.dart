import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class KosarajuAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.kosaraju;

  @override
  String get name => "Kosaraju's SCC";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return KosarajuGenerator.generate(graph);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.stackPhase, op: AlgoOp.pushStack),
    AlgoInstruction(phase: AlgoPhase.stackPhase, op: AlgoOp.popStack),
    AlgoInstruction(phase: AlgoPhase.exploration, op: AlgoOp.visitNode),
  ];
}

class KosarajuGenerator {
  static List<GraphStep> generate(GraphModel graph) {
    final steps = <GraphStep>[];

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    final visited = <String>{};
    final stack = <String>[];

    // ---------- FIRST DFS ----------
    void dfs1(String u) {
      visited.add(u);
      nodes[u] = nodes[u]!.copyWith(state: NodeState.current);

      steps.add(_step(nodes, edges, stack, u, AlgoPhase.initialization));

      for (final e in graph.outgoingEdges(u)) {
        final v = e.to;
        edges[e.id] = e.copyWith(state: EdgeState.exploring);

        if (!visited.contains(v)) {
          dfs1(v);
        }
      }

      stack.add(u);
      nodes[u] = nodes[u]!.copyWith(state: NodeState.visited);

      steps.add(_step(nodes, edges, stack, null, AlgoPhase.exploration));
    }

    for (final v in nodes.keys) {
      if (!visited.contains(v)) {
        dfs1(v);
      }
    }

    // ---------- TRANSPOSE GRAPH ----------
    final transpose = graph.transpose();

    // reset states
    for (final id in nodes.keys) {
      nodes[id] = nodes[id]!.copyWith(state: NodeState.unvisited);
    }

    steps.add(_step(nodes, edges, stack, null, AlgoPhase.exploration));

    visited.clear();

    // ---------- SECOND DFS ----------
    void dfs2(String u, int sccIndex) {
      visited.add(u);

      nodes[u] = nodes[u]!.copyWith(state: NodeState.scc, sccId: sccIndex);

      steps.add(_step(nodes, edges, stack, u, AlgoPhase.exploration));

      for (final e in transpose.outgoingEdges(u)) {
        final v = e.to;
        if (!visited.contains(v)) {
          dfs2(v, sccIndex);
        }
      }
    }

    int scc = 0;
    while (stack.isNotEmpty) {
      final u = stack.removeLast();
      if (!visited.contains(u)) {
        dfs2(u, scc++);
      }
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
