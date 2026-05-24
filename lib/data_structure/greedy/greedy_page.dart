import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/algorithm_utils/algo_info.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/data_structure/algorithm_utils/algorithm_factory.dart';
import 'package:algov/main_screen/saved_screen.dart';
import 'package:algov/ui/widgets/app_widgets/algo_screen.dart';
import 'package:flutter/material.dart';

class Greedy {
  List<AlgorithmInfo> allAlgorithms = [
    Greedy.dijkstraRepo,
    Greedy.kruskalRepo,
    Greedy.primRepo,
  ];

  static final dijkstra = AlgorithmFactory.graphfunc(GraphAlgoType.dijkstra);
  static final dijkstraRepo = AlgorithmRepository.graphAlgos[2];
  static final kruskalRepo = AlgorithmRepository.graphAlgos[6];
  static final primRepo = AlgorithmRepository.graphAlgos[7];
}

class Recursive {
  static final mergeRepo = AlgorithmRepository.sortingAlgorithms[3];
  static final quickRepo = AlgorithmRepository.sortingAlgorithms[4];
  static final binaryRepo = AlgorithmRepository.searchingAlgorithms[1];
  static final treetraversal0 = AlgorithmRepository.treeAlgos[0];
  static final treetraversal1 = AlgorithmRepository.treeAlgos[1];
  static final treetraversal2 = AlgorithmRepository.treeAlgos[2];
  static final treetraversal3 = AlgorithmRepository.treeAlgos[3];

  List<AlgorithmInfo> allAlgorithm = [
    mergeRepo,
    quickRepo,
    binaryRepo,
    treetraversal0,
    treetraversal1,
    treetraversal2,
    treetraversal3,
  ];
}

class GreedyPage extends StatelessWidget {
  final bool isgreedy;
  const GreedyPage({super.key, required this.isgreedy});

  @override
  Widget build(BuildContext context) {
    return AlgorithmsScreen(
      alorithm: isgreedy ? Greedy().allAlgorithms : Recursive().allAlgorithm,
      function: (algo) {
        openSaved(context, algo.id);
      },
      titleText: isgreedy ? 'Greedy' : "Recursive",
    );
  }
}
