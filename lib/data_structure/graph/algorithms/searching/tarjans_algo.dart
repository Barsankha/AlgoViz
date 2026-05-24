import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class TarjanAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.tarjan;

  @override
  String get name => "Tarjan's Strongly Connected Components";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return TarjanGenerator.generate(graph);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.stackPhase, op: AlgoOp.pushStack),
    AlgoInstruction(phase: AlgoPhase.stackPhase, op: AlgoOp.popStack),
    AlgoInstruction(phase: AlgoPhase.completion, op: AlgoOp.outputResult),
  ];
}

class TarjanGenerator {
  static List<GraphStep> generate(GraphModel graph) {
    final steps = <GraphStep>[];

    int index = 0;
    final stack = <String>[];
    final onStack = <String>{};

    final indices = <String, int>{};
    final low = <String, int>{};

    Map<String, NodeModel> nodes = Map.from(graph.nodes);
    Map<String, EdgeModel> edges = Map.from(graph.edges);

    void strongConnect(String v) {
      indices[v] = index;
      low[v] = index;
      index++;

      stack.add(v);
      onStack.add(v);

      nodes[v] = nodes[v]!.copyWith(state: NodeState.current);

      steps.add(_step(nodes, edges, stack, v, AlgoPhase.initialization));

      for (final e in graph.outgoingEdges(v)) {
        final w = e.to;

        edges[e.id] = e.copyWith(state: EdgeState.exploring);

        if (!indices.containsKey(w)) {
          strongConnect(w);
          low[v] = low[v]!.clamp(0, low[w]!);
        } else if (onStack.contains(w)) {
          low[v] = low[v]!.clamp(0, indices[w]!);
        }
      }

      // Root of SCC
      if (low[v] == indices[v]) {
        String w;
        do {
          w = stack.removeLast();
          onStack.remove(w);

          nodes[w] = nodes[w]!.copyWith(state: NodeState.visited);

          steps.add(_step(nodes, edges, stack, w, AlgoPhase.exploration));
        } while (w != v);
      }
    }

    for (final v in nodes.keys) {
      if (!indices.containsKey(v)) {
        strongConnect(v);
      }
    }

    return steps;
  }

  static GraphStep _step(
    Map<String, NodeModel> nodes,
    Map<String, EdgeModel> edges,
    List<String> stack,
    String? active,
    AlgoPhase pase,
  ) => GraphStep(
    phase: pase,
    activeNodeId: active,
    nodes: Map.from(nodes),
    edges: Map.from(edges),
    frontier: List.from(stack), // reuse frontier as stack
    parents: {},
  );
}
