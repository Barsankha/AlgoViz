import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/models/graph_instruction.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';

class FloydWarshallAlgorithm implements GraphAlgorithm, AlgorithmMeta {
  @override
  GraphAlgoType get type => GraphAlgoType.floydWarshall;

  @override
  String get name => "Floyd–Warshall All-Pairs\n Shortest Pair";

  @override
  List<GraphStep> generate(GraphModel graph, String start) {
    return FloydWarshallGenerator.generate(graph);
  }

  @override
  List<AlgoInstruction> get instructions => const [
    AlgoInstruction(phase: AlgoPhase.initialization, op: AlgoOp.initDistance),
    AlgoInstruction(
      phase: AlgoPhase.relaxation,
      op: AlgoOp.relaxEdge,
      args: {"via": "k"},
    ),
    AlgoInstruction(phase: AlgoPhase.completion, op: AlgoOp.outputResult),
  ];
}

class FloydWarshallGenerator {
  /// Deep clone for animation safety
  static Map<String, Map<String, double>> _clone(
    Map<String, Map<String, double>> src,
  ) {
    return {
      for (final e in src.entries) e.key: Map<String, double>.from(e.value),
    };
  }

  static List<GraphStep> generate(GraphModel graph) {
    final steps = <GraphStep>[];

    final nodes = Map<String, NodeModel>.from(graph.nodes);
    final edges = Map<String, EdgeModel>.from(graph.edges);

    final ids = nodes.keys.toList();

    // -----------------------------
    // 1️⃣ Initialize distance matrix
    // -----------------------------
    final dist = <String, Map<String, double>>{
      for (final i in ids)
        i: {for (final j in ids) j: i == j ? 0.0 : double.infinity},
    };

    // -----------------------------
    // 2️⃣ Load edges (take min for correctness, especially self-loops)
    // -----------------------------
    for (final e in edges.values) {
      final currentForward = dist[e.from]![e.to]!;
      if (e.weight < currentForward) {
        dist[e.from]![e.to] = e.weight;
      }

      // ❗ only mirror if graph is undirected
      if (!graph.directed) {
        if (e.weight < 0) {
          throw Exception(
            'Floyd–Warshall: undirected graph cannot contain negative weights',
          );
        }
        final currentBackward = dist[e.to]![e.from]!;
        if (e.weight < currentBackward) {
          dist[e.to]![e.from] = e.weight;
        }
      }
    }

    // -----------------------------
    // 3️⃣ Initial step
    // -----------------------------
    steps.add(
      GraphStep(
        activeNodeId: null,
        nodes: nodes,
        edges: edges,
        frontier: const [],
        parents: const {},
        phase: AlgoPhase.initialization,
        distanceMatrix: _clone(dist),
      ),
    );

    // -----------------------------
    // 4️⃣ Triple loop
    // -----------------------------
    for (final k in ids) {
      for (final i in ids) {
        for (final j in ids) {
          final dik = dist[i]![k]!;
          final dkj = dist[k]![j]!;

          if (dik == double.infinity || dkj == double.infinity) continue;

          final alt = dik + dkj;

          // exploration step (for UI highlight)
          steps.add(
            GraphStep(
              nodes: nodes,
              edges: edges,
              distanceMatrix: _clone(dist),
              i: i,
              j: j,
              k: k,
              phase: AlgoPhase.exploration,
            ),
          );

          if (alt < dist[i]![j]!) {
            dist[i]![j] = alt;

            steps.add(
              GraphStep(
                activeNodeId: k,
                nodes: nodes,
                edges: edges,
                frontier: const [],
                parents: const {},
                phase: AlgoPhase.relaxation,
                i: i,
                j: j,
                k: k,
                distanceMatrix: _clone(dist),
              ),
            );
          }
        }
      }
    }

    // -----------------------------
    // 5️⃣ Negative cycle detection (after full execution)
    // -----------------------------
    String? negativeCycleNode;
    for (final node in ids) {
      if (dist[node]![node]! < 0) {
        negativeCycleNode = node;
        break;
      }
    }

    // -----------------------------
    // 6️⃣ Completion step
    // -----------------------------
    steps.add(
      GraphStep(
        activeNodeId: negativeCycleNode,
        nodes: nodes,
        edges: edges,
        frontier: const [],
        parents: const {},
        phase: AlgoPhase.completion,
        distanceMatrix: _clone(dist),
      ),
    );

    return steps;
  }
}

// class FloydWarshallGenerator {
//   static Map<String, Map<String, double>> _clone(
//     Map<String, Map<String, double>> src,
//   ) {
//     return {
//       for (final e in src.entries) e.key: Map<String, double>.from(e.value),
//     };
//   }

//   static List<GraphStep> generate(GraphModel graph) {
//     final steps = <GraphStep>[];

//     Map<String, NodeModel> nodes = Map.from(graph.nodes);
//     final edges = Map<String, EdgeModel>.from(graph.edges);

//     final ids = nodes.keys.toList();

//     // ---- initialize dist matrix ----
//     final dist = {
//       for (final i in ids)
//         i: {for (final j in ids) j: i == j ? 0.0 : double.infinity},
//     };

//     for (final e in edges.values) {
//       dist[e.from]![e.to] = e.weight;
//       dist[e.to]![e.from] = e.weight;
//     }

//     // store matrix in all nodes (same reference snapshot)
//     nodes = nodes.map((id, n) {
//       return MapEntry(id, n.copyWith(meta: {'dist': Map.from(dist[id]!)}));
//     });

//     steps.add(
//       GraphStep(
//         activeNodeId: null,
//         nodes: Map.from(nodes),
//         edges: edges,
//         frontier: const [],
//         parents: const {},
//         phase: AlgoPhase.initialization,
//         distanceMatrix: _clone(dist),
//       ),
//     );

//     // ---- triple loop ----
//     for (final k in ids) {
//       for (final i in ids) {
//         for (final j in ids) {
//           final alt = dist[i]![k]! + dist[k]![j]!;
//           steps.add(
//             GraphStep(
//               nodes: nodes,
//               edges: edges,
//               distanceMatrix: _clone(dist),
//               i: i,
//               j: j,
//               k: k,
//               phase: AlgoPhase.exploration,
//             ),
//           );
//           if (alt < dist[i]![j]!) {
//             dist[i]![j] = alt;

//             nodes = nodes.map((id, n) {
//               return MapEntry(
//                 id,
//                 n.copyWith(meta: {'dist': Map.from(dist[id]!)}),
//               );
//             });

//             steps.add(
//               GraphStep(
//                 activeNodeId: k,
//                 nodes: Map.from(nodes),
//                 edges: edges,
//                 frontier: const [],
//                 parents: const {},
//                 phase: AlgoPhase.relaxation,
//                 i: i,
//                 j: j,
//                 k: k,
//                 distanceMatrix: _clone(dist),
//               ),
//             );
//           }
//         }
//       }
//     }

//     return steps;
//   }
// }
