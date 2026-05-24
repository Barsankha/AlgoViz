import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';

class TreeModel {
  final String rootId;
  final Map<String, NodeModel> nodes;
  final Map<String, EdgeModel> edges;

  const TreeModel({
    required this.rootId,
    required this.nodes,
    required this.edges,
  });

  GraphModel toGraph() {
    return GraphModel(nodes: nodes, edges: edges, directed: true);
  }
}

//
List<String> getOrderedChildren(TreeModel tree, String nodeId) {
  final children =
      tree.edges.values
          .where((e) => e.from == nodeId)
          .map((e) => e.to)
          .toList();
  children.sort(
    (a, b) => tree.nodes[a]!.position.dx.compareTo(tree.nodes[b]!.position.dx),
  );
  return children;
}

String findEdgeId(TreeModel tree, String from, String to) {
  for (final entry in tree.edges.entries) {
    if (entry.value.from == from && entry.value.to == to) {
      return entry.key;
    }
  }
  throw Exception('Edge not found'); // Should never happen in valid tree
}

//
