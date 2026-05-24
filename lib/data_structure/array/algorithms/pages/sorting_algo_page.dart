import 'package:algov/core/engine/controller/sorting_controller.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/ui/screens/custom_screen/search_screen.dart';
import 'package:algov/ui/widgets/app_widgets/algo_screen.dart';
import 'package:flutter/cupertino.dart';

class SortingAlgorithmsMainPage extends StatefulWidget {
  final bool isSearch;
  const SortingAlgorithmsMainPage({super.key, required this.isSearch});

  @override
  State<SortingAlgorithmsMainPage> createState() =>
      _SortingAlgorithmsMainPageState();
}

class _SortingAlgorithmsMainPageState extends State<SortingAlgorithmsMainPage> {
  late SortingController controller;

  @override
  void initState() {
    super.initState();
    controller = SortingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final algorithms = AlgorithmRepository.sortingAlgorithms;
    if (widget.isSearch) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: AlgoScreen(
          query: '',
          alorithm: algorithms,
          function: (algo) {
            controller.reset();
            routeFunction(context, algo.algoCategory, algo);
          },
        ),
      );
    }
    return AlgorithmsScreen(
      titleText: "Sorting Algorithms",
      alorithm: algorithms,
      function: (algo) {
        controller.reset();
        routeFunction(context, algo.algoCategory, algo);
      },
    );
  }
}
