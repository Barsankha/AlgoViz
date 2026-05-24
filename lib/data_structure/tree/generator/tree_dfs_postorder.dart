import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:algov/data_structure/tree/models/tree_algo.dart';
import 'package:algov/data_structure/tree/models/tree_model.dart';

class TreeDfsPostAlgorithm implements TreeAlgorithm {
  @override
  TreeAlgoType get type => TreeAlgoType.bfs;

  @override
  String get name => "Tree Dfs";

  @override
  List<GraphStep> generate(TreeModel tree) {
    return TreeDfsPostGenerator.generate(tree);
  }
}

class TreeDfsPostGenerator {
  static List<GraphStep> generate(TreeModel tree) {
    // Identical setup to Pre-order...
    final steps = <GraphStep>[];
    final traversalOrder = <String>[];
    final nodeStates = <String, NodeState>{
      for (var id in tree.nodes.keys) id: NodeState.normal,
    };
    final edgeStates = <String, EdgeState>{
      for (var id in tree.edges.keys) id: EdgeState.normal,
    };
    final parents = <String, String>{};
    final currentPath = <String>[];

    Map<String, NodeModel> nodes() => {
      for (var e in tree.nodes.entries)
        e.key: e.value.copyWith(state: nodeStates[e.key]!),
    };

    Map<String, EdgeModel> edges() {
      final map = {
        for (var e in tree.edges.entries)
          e.key: e.value.copyWith(state: edgeStates[e.key]!),
      };
      // Highlight current recursion path with exploring (orange) edges
      for (var i = 0; i < currentPath.length - 1; i++) {
        final edgeId = findEdgeId(tree, currentPath[i], currentPath[i + 1]);
        map[edgeId] = map[edgeId]!.copyWith(state: EdgeState.exploring);
      }
      return map;
    }

    void addStep({AlgoPhase phase = AlgoPhase.exploration}) {
      steps.add(
        GraphStep(
          nodes: nodes(),
          edges: edges(),
          parents: Map.from(parents),
          activeNodeId: currentPath.isEmpty ? null : currentPath.last,
          phase: phase,
          result: List.from(traversalOrder),
        ),
      );
    }

    // Initialization
    addStep(phase: AlgoPhase.initialization);

    // Only difference: move the visit block AFTER the child loop
    void dfs(String node) {
      currentPath.add(node);
      nodeStates[node] = NodeState.current;
      addStep(phase: AlgoPhase.exploration);

      final children = getOrderedChildren(tree, node);
      for (final child in children) {
        // Same discovery/relaxation steps as Pre
        // ...
        final edgeId = findEdgeId(tree, node, child);

        // Explore edge
        addStep(phase: AlgoPhase.relaxation);

        // Discover child
        nodeStates[child] = NodeState.discovered;

        parents[child] = node;
        edgeStates[edgeId] = EdgeState.selected; // permanent tree edge
        addStep(phase: AlgoPhase.relaxation);
        dfs(child);

        addStep(phase: AlgoPhase.exploration);
      }

      // === Post-order visit (moved here) ===
      nodeStates[node] = NodeState.path; // purple
      traversalOrder.add(node);

      addStep(phase: AlgoPhase.exploration);

      nodeStates[node] = NodeState.visited;
      addStep(phase: AlgoPhase.exploration);
      currentPath.removeLast();
    }

    // Rest identical to Pre-order
    dfs(tree.rootId);

    // Completed
    addStep(phase: AlgoPhase.completion);

    return steps;
  }
}
