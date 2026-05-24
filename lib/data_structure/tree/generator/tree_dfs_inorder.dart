import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:algov/data_structure/tree/models/tree_algo.dart';
import 'package:algov/data_structure/tree/models/tree_model.dart';

class TreeDfsInAlgorithm implements TreeAlgorithm {
  @override
  TreeAlgoType get type => TreeAlgoType.bfs;

  @override
  String get name => "Tree BFS";

  @override
  List<GraphStep> generate(TreeModel tree) {
    return TreeDfsInGenerator.generate(tree);
  }
}

class TreeDfsInGenerator {
  static List<GraphStep> generate(TreeModel tree) {
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

    void dfs(String node) {
      currentPath.add(node);
      nodeStates[node] = NodeState.current;
      addStep(phase: AlgoPhase.exploration);

      final children = getOrderedChildren(tree, node);

      // ==== LEFT subtree ====
      if (children.isNotEmpty) {
        final left = children[0];
        final edgeId = findEdgeId(tree, node, left);

        addStep(phase: AlgoPhase.relaxation);

        nodeStates[left] = NodeState.discovered;
        parents[left] = node;
        edgeStates[edgeId] = EdgeState.selected;
        addStep(phase: AlgoPhase.relaxation);

        dfs(left);

        edgeStates[edgeId] = EdgeState.normal;
        addStep(phase: AlgoPhase.exploration);
      }

      // ==== INORDER VISIT ====
      nodeStates[node] = NodeState.path; // visit
      traversalOrder.add(node);
      addStep(phase: AlgoPhase.exploration);

      // ==== RIGHT subtree ====
      if (children.length > 1) {
        final right = children[1];
        final edgeId = findEdgeId(tree, node, right);

        addStep(phase: AlgoPhase.relaxation);

        nodeStates[right] = NodeState.discovered;
        parents[right] = node;
        edgeStates[edgeId] = EdgeState.selected;
        addStep(phase: AlgoPhase.relaxation);

        dfs(right);

        edgeStates[edgeId] = EdgeState.normal;
        addStep(phase: AlgoPhase.exploration);
      }

      nodeStates[node] = NodeState.visited;
      addStep(phase: AlgoPhase.exploration);

      currentPath.removeLast();
    }

    // Root discovery
    nodeStates[tree.rootId] = NodeState.discovered;
    dfs(tree.rootId);

    addStep(phase: AlgoPhase.completion);
    return steps;
  }
}
