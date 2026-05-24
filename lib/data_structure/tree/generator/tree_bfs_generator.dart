import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:algov/data_structure/tree/models/tree_algo.dart';
import 'package:algov/data_structure/tree/models/tree_model.dart';

class TreeBfsAlgorithm implements TreeAlgorithm {
  @override
  TreeAlgoType get type => TreeAlgoType.bfs;

  @override
  String get name => "Tree BFS";

  @override
  List<GraphStep> generate(TreeModel tree) {
    return TreeBfsGenerator.generate(tree);
  }

  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.initialization, op: AlgoOp.initIndegree),
    AlgoInstruction(phase: AlgoPhase.exploration, op: AlgoOp.visitNode),
    AlgoInstruction(phase: AlgoPhase.relaxation, op: AlgoOp.enqueue),
    AlgoInstruction(phase: AlgoPhase.completion, op: AlgoOp.outputResult),
  ];
}

class TreeBfsGenerator {
  static List<GraphStep> generate(TreeModel tree) {
    final steps = <GraphStep>[];
    final traversalOrder = <String>[];

    final baseNodes = tree.nodes;
    final baseEdges = tree.edges;
    final root = tree.rootId;

    // Mutable state trackers (only states change, positions are fixed in base)
    final nodeStates = <String, NodeState>{
      for (var id in baseNodes.keys) id: NodeState.normal,
    };

    final edgeStates = <String, EdgeState>{
      for (var id in baseEdges.keys) id: EdgeState.normal,
    };

    final parents = <String, String>{};
    final queue = <String>[];

    // Helpers to snapshot current nodes/edges with updated states
    Map<String, NodeModel> getCurrentNodes() {
      return {
        for (var entry in baseNodes.entries)
          entry.key: entry.value.copyWith(
            state: nodeStates[entry.key] ?? NodeState.normal,
          ),
      };
    }

    Map<String, EdgeModel> getCurrentEdges() {
      return {
        for (var entry in baseEdges.entries)
          entry.key: entry.value.copyWith(
            state: edgeStates[entry.key] ?? EdgeState.normal,
          ),
      };
    }

    // === Initialization ===
    queue.add(root);
    nodeStates[root] = NodeState.discovered; // Root enters frontier

    steps.add(
      GraphStep(
        nodes: getCurrentNodes(),
        edges: getCurrentEdges(),
        frontier: List.from(queue),
        parents: Map.from(parents),
        phase: AlgoPhase.initialization,
        result: List<String>.from(traversalOrder),
      ),
    );

    // === BFS Loop ===
    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      traversalOrder.add(current);
      // Mark as currently processing
      nodeStates[current] = NodeState.current;

      steps.add(
        GraphStep(
          nodes: getCurrentNodes(),
          edges: getCurrentEdges(),
          frontier: List.from(queue),
          parents: Map.from(parents),
          activeNodeId: current,
          phase: AlgoPhase.exploration,
          result: List<String>.from(traversalOrder),
        ),
      );

      // Process each outgoing edge/child
      final outgoingEdges = baseEdges.values.where((e) => e.from == current);
      for (final edge in outgoingEdges) {
        final child = edge.to;

        // Skip if already discovered (safe for general graphs, harmless for trees)
        if (nodeStates[child] != NodeState.normal) continue;

        // === Relaxation: explore edge ===
        edgeStates[edge.id] = EdgeState.exploring;

        steps.add(
          GraphStep(
            nodes: getCurrentNodes(),
            edges: getCurrentEdges(),
            frontier: List.from(queue),
            parents: Map.from(parents),
            activeNodeId: current,
            phase: AlgoPhase.relaxation,
            result: List<String>.from(traversalOrder),
          ),
        );

        // === Relaxation: discover child ===
        queue.add(child);
        nodeStates[child] = NodeState.discovered;
        parents[child] = current;
        edgeStates[edge.id] = EdgeState.selected; // Permanent for tree edges

        steps.add(
          GraphStep(
            nodes: getCurrentNodes(),
            edges: getCurrentEdges(),
            frontier: List.from(queue),
            parents: Map.from(parents),
            activeNodeId: current,
            phase: AlgoPhase.relaxation,
            result: List<String>.from(traversalOrder),
          ),
        );
      }

      // === Finish processing current node ===
      nodeStates[current] = NodeState.visited;

      steps.add(
        GraphStep(
          nodes: getCurrentNodes(),
          edges: getCurrentEdges(),
          frontier: List.from(queue),
          parents: Map.from(parents),
          activeNodeId: current,
          phase: AlgoPhase.exploration,
          result: List<String>.from(traversalOrder),
        ),
      );
    }

    // Optional: add a final "completed" step if your UI expects it
    // steps.add(GraphStep(... phase: AlgoPhase.completed, frontier: [], activeNodeId: null));

    return steps;
  }
}
