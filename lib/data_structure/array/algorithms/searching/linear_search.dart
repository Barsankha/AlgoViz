import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';

class LinearSearchAlgorithm implements SearchingAlgorithm {
  //final int target;

  //LinearSearchAlgorithm(this.target);

  @override
  String get name => "Linear Search";

  @override
  Future<void> search(
    List<SearchItem> items,
    Future<void> Function() refresh,
    Duration delay,
    SearchAlgoController controller,
    int target,
  ) async {
    for (int i = 0; i < items.length; i++) {
      // Reset active state
      for (final item in items) {
        item.isActive = false;
      }

      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[i].value == target) {
        items[i].isFound = true; // FOUND
        items[i].isActive = false;
        await refresh();
        return;
      }
    }

    // Not found → clear highlights
    for (final item in items) {
      item.isActive = false;
    }
    await refresh();
  }

  @override
  bool get requiresSorted => false;
}
