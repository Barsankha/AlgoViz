import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/ui/screens/custom_screen/search_screen.dart';
import 'package:algov/ui/widgets/app_widgets/algo_screen.dart';
import 'package:flutter/cupertino.dart';

class SearchingAlgorithmsMainPage extends StatefulWidget {
  final bool issearch;
  const SearchingAlgorithmsMainPage({super.key, required this.issearch});

  @override
  State<SearchingAlgorithmsMainPage> createState() =>
      _SearchingAlgorithmsMainPageState();
}

class _SearchingAlgorithmsMainPageState
    extends State<SearchingAlgorithmsMainPage> {
  late SearchAlgoController controller;

  @override
  void initState() {
    super.initState();
    controller = SearchAlgoController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final algorithms = AlgorithmRepository.searchingAlgorithms;
    if (widget.issearch) {
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
      titleText: "Searching Algorithms",
      alorithm: algorithms,
      function: (algo) {
        controller.reset();
        routeFunction(context, algo.algoCategory, algo);
      },
    );
  }
}
