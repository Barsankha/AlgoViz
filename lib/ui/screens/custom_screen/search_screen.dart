import 'package:algov/app/routes.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/data_structure/algorithm_utils/algorithm_factory.dart';
import 'package:algov/data_structure/array/models/search_item.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/tree/models/tree_algo.dart';
import 'package:algov/ui/widgets/app_widgets/algo_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlgorithmsScreen(
      titleText: 'Search',
      alorithm: AlgorithmRepository.alorithm,
      function: (algo) {
        routeFunction(context, algo.algoCategory, algo);
      },
    );
  }
}

///////////////////////////////
void routeFunction(BuildContext context, AlgoCategory algo, dynamic algos) {
  final al = AlgorithmFactory.search(algo, algos.type);

  if (al is SortingAlgorithm || al is SearchingAlgorithm) {
    RouteAnim.push(context, RouteAnim.buildScreen(al, algos), AnimType.slide);
  } else if (al is TreeAlgorithm) {
    RouteAnim.push(context, RouteAnim.buildTree(al, algos), AnimType.circular);
  } else if (al is GraphAlgorithm) {
    RouteAnim.push(context, RouteAnim.buildGraph(al, algos), AnimType.circular);
  } else {
    RouteAnim.push(context, al, AnimType.slide);
  }
}
