import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';

class BinarySearchAlgorithm implements SearchingAlgorithm {
  //final int target;

  //BinarySearchAlgorithm(this.target);

  @override
  String get name => "Binary Search";

  @override
  Future<void> search(
    List<SearchItem> items,
    Future<void> Function() refresh,
    Duration delay,
    SearchAlgoController controller,
    int target,
  ) async {
    int low = 0;
    int high = items.length - 1;

    while (low <= high) {
      // Clear previous states
      for (final item in items) {
        item.isActive = false;
      }

      int mid = (low + high) ~/ 2;
      items[mid].isActive = true;

      await refresh();
      await Future.delayed(delay);

      if (items[mid].value == target) {
        items[mid].isFound = true; // FOUND
        items[mid].isActive = false;
        await refresh();
        return;
      } else if (items[mid].value < target) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    // Not found
    for (final item in items) {
      item.isActive = false;
    }
    await refresh();
  }

  @override
  bool get requiresSorted => true;
}
