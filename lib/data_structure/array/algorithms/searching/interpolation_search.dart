import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';

class InterpolationSearch implements SearchingAlgorithm {
  @override
  String get name => "Interpolation Search";

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

    while (low <= high &&
        target >= items[low].value &&
        target <= items[high].value) {
      if (low == high) {
        items[low].isActive = true;
        await refresh();
        if (items[low].value == target) {
          items[low].isFound = true;
        }
        return;
      }

      int pos =
          low +
          (((target - items[low].value) * (high - low)) ~/
              (items[high].value - items[low].value));

      items[pos].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[pos].value == target) {
        items[pos].isFound = true;
        await refresh();
        return;
      }

      items[pos].isActive = false;

      if (items[pos].value < target) {
        low = pos + 1;
      } else {
        high = pos - 1;
      }
    }
  }

  @override
  bool get requiresSorted => true;
}
