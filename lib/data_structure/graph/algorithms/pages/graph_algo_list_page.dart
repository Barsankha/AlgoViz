import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/ui/screens/custom_screen/search_screen.dart';
import 'package:algov/ui/widgets/app_widgets/algo_screen.dart';
import 'package:flutter/material.dart';

class GraphAlgoListPage extends StatelessWidget {
  final bool isSearch;
  final bool isGraph;
  const GraphAlgoListPage({
    super.key,
    required this.isSearch,
    required this.isGraph,
  });

  @override
  Widget build(BuildContext context) {
    final algorithms =
        isGraph
            ? AlgorithmRepository.graphAlgos
            : AlgorithmRepository.treeAlgos;

    if (isSearch) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: AlgoScreen(
          alorithm: algorithms,
          query: '',
          function: (algo) {
            routeFunction(context, algo.algoCategory, algo);
          },
        ),
      );
    }
    return AlgorithmsScreen(
      titleText: isGraph ? "Graph" : "Tree",
      alorithm: algorithms,
      function: (algo) {
        routeFunction(context, algo.algoCategory, algo);
      },
    );
  }
}
