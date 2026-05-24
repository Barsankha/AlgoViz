import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:algov/data_structure/tree/models/tree_model.dart';

abstract class TreeAlgorithm implements Algo {
  TreeAlgoType get type;
  @override
  String get name;
  List<GraphStep> generate(TreeModel tree);
}
