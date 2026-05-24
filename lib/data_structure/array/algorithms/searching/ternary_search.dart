import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';

class TernarySearch implements SearchingAlgorithm {
  @override
  String get name => "Ternary Search";

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
      int third = (high - low) ~/ 3;

      int mid1 = low + third;
      int mid2 = high - third;

      // Activate mid1
      items[mid1].isActive = true;
      await refresh();
      await Future.delayed(delay);

      // Activate mid2
      items[mid2].isActive = true;
      await refresh();
      await Future.delayed(delay);

      // Check mid1
      if (items[mid1].value == target) {
        items[mid1].isFound = true;
        await refresh();
        return;
      }

      // Check mid2
      if (items[mid2].value == target) {
        items[mid2].isFound = true;
        await refresh();
        return;
      }

      // Deactivate mids
      items[mid1].isActive = false;
      items[mid2].isActive = false;

      // Narrow range
      if (target < items[mid1].value) {
        high = mid1 - 1;
      } else if (target > items[mid2].value) {
        low = mid2 + 1;
      } else {
        low = mid1 + 1;
        high = mid2 - 1;
      }

      await refresh();
      await Future.delayed(delay);
    }
  }

  @override
  bool get requiresSorted => true;
}
