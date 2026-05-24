import 'dart:math';

import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';

class ExponentialSearch implements SearchingAlgorithm {
  @override
  String get name => "Exponential Search";

  @override
  Future<void> search(
    List<SearchItem> items,
    Future<void> Function() refresh,
    Duration delay,
    SearchAlgoController controller,
    int target,
  ) async {
    if (items[0].value == target) {
      items[0].isFound = true;
      await refresh();
      return;
    }

    int i = 1;
    while (i < items.length && items[i].value <= target) {
      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);

      items[i].isActive = false;
      i *= 2;
    }

    await _binarySearch(
      items,
      target,
      i ~/ 2,
      min(i, items.length - 1),
      refresh,
      delay,
    );
  }

  Future<void> _binarySearch(
    List<SearchItem> items,
    int target,
    int low,
    int high,
    Future<void> Function() refresh,
    Duration delay,
  ) async {
    while (low <= high) {
      int mid = (low + high) ~/ 2;

      items[mid].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[mid].value == target) {
        items[mid].isFound = true;
        await refresh();
        return;
      }

      items[mid].isActive = false;

      if (items[mid].value < target) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
  }

  @override
  bool get requiresSorted => true;
}
