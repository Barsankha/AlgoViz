import 'dart:ui';

import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:algov/data_structure/tree/models/tree_model.dart';

class GraphFactory {
  static List<dynamic> whichGraph(dynamic type) {
    if (type == GraphAlgoType.breathFirstSearch ||
        type == GraphAlgoType.depthFirstSearch ||
        type == GraphAlgoType.topologicalSort ||
        type == GraphAlgoType.kahns) {
      return [simple(), 'S'];
    } else if (type == GraphAlgoType.prims ||
        type == GraphAlgoType.kruskal ||
        type == GraphAlgoType.dijkstra ||
        type == GraphAlgoType.aStar) {
      return [weightsGraph(), 'A'];
    } else if (type == GraphAlgoType.bellManFord ||
        type == GraphAlgoType.floydWarshall) {
      return [noNegCycle(), 'S'];
    } else if (type is TreeAlgoType) {
      return [generictree(), 'A'];
    } else if (type is BinaryTreeAlgoType) {
      return [binaryTree(), '1'];
    }
    if (type is LinkedListAlgoType) {
      return [linkedListModel(), '10'];
    } else //if (type == GraphAlgoType.tarjan || type == GraphAlgoType.kosaraju)
    {
      return [multipleScc(), 'A'];
    }
  }

  static GraphModel simple() => buildDagForTraversalAndTopo();
  static GraphModel weightsGraph() =>
      buildUndirectedWeightedForMstAndShortest();
  static GraphModel noNegCycle() => buildDirectedWithNegativeForShortest();
  static GraphModel multipleScc() => buildDirectedForScc();
  static TreeModel generictree() => buildGenericTree();
  static TreeModel binaryTree() => buildBinaryTree();
  static GraphModel linkedListModel() => buildSampleLinkedList();
}

GraphModel buildSampleLinkedList() {
  final nodes = {
    // Level 1
    '1': NodeModel(id: '1', label: '1', position: const Offset(0.04, 0.5)),

    // Level 2
    '2': NodeModel(id: '2', label: '2', position: const Offset(0.25, 0.5)),
    '3': NodeModel(id: '3', label: '3', position: const Offset(0.45, 0.5)),

    // Level 3
    '4': NodeModel(id: '4', label: '4', position: const Offset(0.65, 0.5)),
    '5': NodeModel(id: '5', label: '5', position: const Offset(0.82, 0.5)),
    '6': NodeModel(id: '6', label: '6', position: const Offset(0.99, 0.5)),
  };

  final edges = {
    'e1': EdgeModel(id: 'e1', from: '1', to: '2', directed: true),
    'e2': EdgeModel(id: 'e2', from: '2', to: '3', directed: true),

    'e3': EdgeModel(id: 'e3', from: '3', to: '4', directed: true),
    'e4': EdgeModel(id: 'e4', from: '4', to: '5', directed: true),

    'e5': EdgeModel(id: 'e5', from: '5', to: '6', directed: true),
  };

  return GraphModel(nodes: nodes, edges: edges);
}

GraphModel buildDagForTraversalAndTopo() {
  final nodes = <String, NodeModel>{
    'S': NodeModel(id: 'S', label: 'S', position: const Offset(0.1, 0.5)),
    'A': NodeModel(id: 'A', label: 'A', position: const Offset(0.3, 0.2)),
    'B': NodeModel(id: 'B', label: 'B', position: const Offset(0.3, 0.8)),
    'C': NodeModel(id: 'C', label: 'C', position: const Offset(0.55, 0.1)),
    'D': NodeModel(id: 'D', label: 'D', position: const Offset(0.55, 0.5)),
    'E': NodeModel(id: 'E', label: 'E', position: const Offset(0.55, 0.9)),
    'F': NodeModel(id: 'F', label: 'F', position: const Offset(0.85, 0.5)),
  };

  final edges = <String, EdgeModel>{
    'S-A': EdgeModel(id: 'S-A', from: 'S', to: 'A'),
    'S-B': EdgeModel(id: 'S-B', from: 'S', to: 'B'),
    'A-C': EdgeModel(id: 'A-C', from: 'A', to: 'C'),
    'A-D': EdgeModel(id: 'A-D', from: 'A', to: 'D'),
    'B-D': EdgeModel(id: 'B-D', from: 'B', to: 'D'),
    'B-E': EdgeModel(id: 'B-E', from: 'B', to: 'E'),
    'C-F': EdgeModel(id: 'C-F', from: 'C', to: 'F'),
    'D-F': EdgeModel(id: 'D-F', from: 'D', to: 'F'),
    'E-F': EdgeModel(id: 'E-F', from: 'E', to: 'F'),
  };

  return GraphModel(nodes: nodes, edges: edges);
}

// 2. Undirected weighted — Ideal for Prim, Kruskal, Dijkstra, A*
// Positive weights, cycles → clear MST selection, shortest paths
GraphModel buildUndirectedWeightedForMstAndShortest() {
  final nodes = <String, NodeModel>{
    'A': NodeModel(id: 'A', label: 'A', position: const Offset(0.2, 0.2)),
    'B': NodeModel(id: 'B', label: 'B', position: const Offset(0.8, 0.2)),
    'C': NodeModel(id: 'C', label: 'C', position: const Offset(0.5, 0.4)),
    'D': NodeModel(id: 'D', label: 'D', position: const Offset(0.15, 0.7)),
    'E': NodeModel(id: 'E', label: 'E', position: const Offset(0.85, 0.7)),
    'F': NodeModel(id: 'F', label: 'F', position: const Offset(0.5, 0.85)),
  };

  final edges = <String, EdgeModel>{};

  void addBidirectional(String u, String v, double w) {
    edges['$u-$v'] = EdgeModel(
      id: '$u-$v',
      from: u,
      to: v,
      weight: w,
      directed: false,
    );
    edges['$v-$u'] = EdgeModel(id: '$v-$u', from: v, to: u, weight: w);
  }

  addBidirectional('A', 'B', 7);
  addBidirectional('A', 'C', 3);
  addBidirectional('A', 'D', 4);
  addBidirectional('B', 'C', 8);
  addBidirectional('B', 'E', 5);
  addBidirectional('C', 'E', 6);
  addBidirectional('C', 'F', 2);
  addBidirectional('D', 'F', 9);
  addBidirectional('E', 'F', 4);

  return GraphModel(nodes: nodes, edges: edges);
}

// 3. Directed with negative edges (no neg cycle) — Bellman-Ford, Floyd-Warshall, contrast with Dijkstra
// Classic negative edge case + extra paths
GraphModel buildDirectedWithNegativeForShortest() {
  final nodes = <String, NodeModel>{
    'S': NodeModel(id: 'S', label: 'S', position: const Offset(0.1, 0.5)),
    'A': NodeModel(id: 'A', label: 'A', position: const Offset(0.3, 0.3)),
    'B': NodeModel(id: 'B', label: 'B', position: const Offset(0.3, 0.7)),
    'C': NodeModel(id: 'C', label: 'C', position: const Offset(0.7, 0.3)),
    'D': NodeModel(id: 'D', label: 'D', position: const Offset(0.75, 0.75)),
    'E': NodeModel(id: 'E', label: 'E', position: const Offset(0.75, 0.07)),
    'F': NodeModel(id: 'F', label: 'F', position: const Offset(0.95, 0.5)),
  };

  final edges = <String, EdgeModel>{
    // Classic negative edge case (Dijkstra fails here)
    'S-A': EdgeModel(id: 'S-A', from: 'S', to: 'A', weight: 5.0),
    'S-B': EdgeModel(id: 'S-B', from: 'S', to: 'B', weight: 10.0),
    'B-A': EdgeModel(
      id: 'B-A',
      from: 'B',
      to: 'A',
      weight: -6.0,
    ), // negative edge
    // Additional paths for variety and multiple relaxations
    'A-C': EdgeModel(id: 'A-C', from: 'A', to: 'C', weight: 8.0),
    'B-C': EdgeModel(id: 'B-C', from: 'B', to: 'C', weight: 2.0),
    'C-D': EdgeModel(id: 'C-D', from: 'C', to: 'D', weight: 3.0),
    'A-D': EdgeModel(id: 'A-D', from: 'A', to: 'D', weight: 8.0),
    'B-D': EdgeModel(id: 'B-D', from: 'B', to: 'D', weight: 4.0),

    // New exclusive chain from A → E → F (only reachable through A)
    // This creates a clear failure case for Dijkstra:
    // - Dijkstra finalizes A with wrong distance (5 instead of 4)
    // - It then propagates the wrong distance to E and F, never correcting it
    // - Bellman-Ford correctly updates A late, then propagates to E and F over multiple iterations
    'A-E': EdgeModel(id: 'A-E', from: 'A', to: 'E', weight: 9.0),
    'E-F': EdgeModel(id: 'E-F', from: 'E', to: 'F', weight: 6.0),
  };

  return GraphModel(nodes: nodes, edges: edges, directed: true);
}

// 4. Directed with multiple SCCs — Tarjan, Kosaraju
// Three clear strongly connected components
GraphModel buildDirectedForScc() {
  final nodes = <String, NodeModel>{
    'A': NodeModel(id: 'A', label: 'A', position: const Offset(0.2, 0.1)),
    'B': NodeModel(id: 'B', label: 'B', position: const Offset(0.4, 0.35)),
    'C': NodeModel(id: 'C', label: 'C', position: const Offset(0.2, 0.9)),
    'D': NodeModel(id: 'D', label: 'D', position: const Offset(0.7, 0.1)),
    'E': NodeModel(id: 'E', label: 'E', position: const Offset(0.85, 0.5)),
    'F': NodeModel(id: 'F', label: 'F', position: const Offset(0.7, 0.9)),
    'G': NodeModel(id: 'G', label: 'G', position: const Offset(0.99, 0.4)),
    'H': NodeModel(id: 'H', label: 'H', position: const Offset(0.05, 0.5)),
  };

  final edges = <String, EdgeModel>{
    // SCC 1: A↔B↔C (fully connected cycle)
    'A-B': EdgeModel(id: 'A-B', from: 'A', to: 'B', weight: 1),
    'B-C': EdgeModel(id: 'B-C', from: 'B', to: 'C', weight: 1),
    'C-A': EdgeModel(id: 'C-A', from: 'C', to: 'A', weight: 1),

    // SCC 2: D→E→F→D
    'D-E': EdgeModel(id: 'D-E', from: 'D', to: 'E', weight: 1),
    'E-F': EdgeModel(id: 'E-F', from: 'E', to: 'F', weight: 1),
    'F-D': EdgeModel(id: 'F-D', from: 'F', to: 'D', weight: 1),

    // SCC 3: G (single)
    // Connecting edges (no back edges)
    'H-A': EdgeModel(id: 'H-A', from: 'H', to: 'A', weight: 1),
    'C-D': EdgeModel(id: 'C-D', from: 'C', to: 'D', weight: 1),
    'F-G': EdgeModel(id: 'F-G', from: 'F', to: 'G', weight: 1),
  };

  return GraphModel(nodes: nodes, edges: edges, directed: true);
}

TreeModel buildBinaryTree() {
  final nodes = {
    // Level 1
    '1': NodeModel(id: '1', label: '1', position: const Offset(0.5, 0.05)),

    // Level 2
    '2': NodeModel(id: '2', label: '2', position: const Offset(0.25, 0.2)),
    '3': NodeModel(id: '3', label: '3', position: const Offset(0.75, 0.2)),

    // Level 3
    '4': NodeModel(id: '4', label: '4', position: const Offset(0.125, 0.4)),
    '5': NodeModel(id: '5', label: '5', position: const Offset(0.375, 0.4)),
    '6': NodeModel(id: '6', label: '6', position: const Offset(0.625, 0.4)),
    '7': NodeModel(id: '7', label: '7', position: const Offset(0.875, 0.4)),

    // Level 4 (Leaves)
    '8': NodeModel(id: '8', label: '8', position: const Offset(0.0625, 0.7)),
    '9': NodeModel(id: '9', label: '9', position: const Offset(0.1875, 0.7)),
    '10': NodeModel(id: '10', label: '10', position: const Offset(0.3125, 0.7)),
    '11': NodeModel(id: '11', label: '11', position: const Offset(0.4375, 0.7)),
    '12': NodeModel(id: '12', label: '12', position: const Offset(0.5625, 0.7)),
    '13': NodeModel(id: '13', label: '13', position: const Offset(0.6875, 0.7)),
    '14': NodeModel(id: '14', label: '14', position: const Offset(0.8125, 0.7)),
    '15': NodeModel(id: '15', label: '15', position: const Offset(0.9375, 0.7)),
  };

  final edges = {
    'e1': EdgeModel(id: 'e1', from: '1', to: '2', directed: true),
    'e2': EdgeModel(id: 'e2', from: '1', to: '3', directed: true),

    'e3': EdgeModel(id: 'e3', from: '2', to: '4', directed: true),
    'e4': EdgeModel(id: 'e4', from: '2', to: '5', directed: true),

    'e5': EdgeModel(id: 'e5', from: '3', to: '6', directed: true),
    'e6': EdgeModel(id: 'e6', from: '3', to: '7', directed: true),

    'e7': EdgeModel(id: 'e7', from: '4', to: '8', directed: true),
    'e8': EdgeModel(id: 'e8', from: '4', to: '9', directed: true),

    'e9': EdgeModel(id: 'e9', from: '5', to: '10', directed: true),
    'e10': EdgeModel(id: 'e10', from: '5', to: '11', directed: true),

    'e11': EdgeModel(id: 'e11', from: '6', to: '12', directed: true),
    'e12': EdgeModel(id: 'e12', from: '6', to: '13', directed: true),

    'e13': EdgeModel(id: 'e13', from: '7', to: '14', directed: true),
    'e14': EdgeModel(id: 'e14', from: '7', to: '15', directed: true),
  };

  return TreeModel(rootId: '1', nodes: nodes, edges: edges);
}

TreeModel buildGenericTree() {
  final nodes = {
    'A': NodeModel(id: 'A', label: 'A', position: const Offset(0.5, 0.1)),
    'B': NodeModel(id: 'B', label: 'B', position: const Offset(0.2, 0.35)),
    'C': NodeModel(id: 'C', label: 'C', position: const Offset(0.5, 0.45)),
    'D': NodeModel(id: 'D', label: 'D', position: const Offset(0.8, 0.35)),
    'E': NodeModel(id: 'E', label: 'E', position: const Offset(0.03, 0.6)),
    'F': NodeModel(id: 'F', label: 'F', position: const Offset(0.2, 0.6)), //
    'G': NodeModel(id: 'G', label: 'G', position: const Offset(0.35, 0.6)),
    'H': NodeModel(id: 'H', label: 'H', position: const Offset(0.5, 0.7)),
    'I': NodeModel(id: 'I', label: 'I', position: const Offset(0.65, 0.6)),
    'J': NodeModel(id: 'J', label: 'J', position: const Offset(0.75, 0.8)),
    'K': NodeModel(id: 'K', label: 'K', position: const Offset(0.9, 0.6)),
  };

  final edges = {
    'e1': EdgeModel(id: 'e1', from: 'A', to: 'B', directed: true),
    'e2': EdgeModel(id: 'e2', from: 'A', to: 'C', directed: true),
    'e3': EdgeModel(id: 'e3', from: 'A', to: 'D', directed: true),
    'e4': EdgeModel(id: 'e4', from: 'B', to: 'E', directed: true),
    'e5': EdgeModel(id: 'e5', from: 'B', to: 'F', directed: true),
    'e6': EdgeModel(id: 'e6', from: 'C', to: 'G', directed: true),
    'e7': EdgeModel(id: 'e7', from: 'C', to: 'H', directed: true),
    'e8': EdgeModel(id: 'e8', from: 'C', to: 'I', directed: true),
    'e9': EdgeModel(
      id: 'e9',
      from: 'H',
      to: 'J',
      directed: true,
    ), // deeper level
    'e10': EdgeModel(id: 'e10', from: 'D', to: 'K', directed: true),
  };

  return TreeModel(rootId: 'A', nodes: nodes, edges: edges);
}

class GraphStepFactory {
  static GraphStep initial(dynamic graph) {
    return GraphStep(
      activeNodeId: null,
      nodes: {
        for (final e in graph.nodes.entries)
          e.key: e.value.copyWith(
            state: NodeState.unvisited, // grey
          ),
      },
      edges: {
        for (final e in graph.edges.entries)
          e.key: e.value.copyWith(
            state: EdgeState.normal, // grey
          ),
      },
      frontier: const [],
      parents: const {},
      phase: AlgoPhase.initialization,
    );
  }
}
