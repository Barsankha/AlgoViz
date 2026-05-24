import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';

abstract class SearchingAlgorithm implements Algo {
  @override
  String get name;
  bool get requiresSorted;

  Future<void> search(
    List<SearchItem> items,
    Future<void> Function() refresh,
    Duration delay,
    SearchAlgoController controller,
    int target,
  );
} //

class SearchItem {
  final int value;
  bool isActive;
  bool isFound;

  SearchItem({
    required this.value,
    this.isActive = false,
    this.isFound = false,
  });
}
