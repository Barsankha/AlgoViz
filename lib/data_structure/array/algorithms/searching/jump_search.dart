import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';
import 'dart:math';

class JumpSearch implements SearchingAlgorithm {
  @override
  String get name => "Jump Search";

  @override
  Future<void> search(
    List<SearchItem> items,
    Future<void> Function() refresh,
    Duration delay,
    SearchAlgoController controller,
    int target,
  ) async {
    final int n = items.length;
    final int step = sqrt(n).toInt();

    int prev = 0;

    while (prev < n && items[min(prev + step, n) - 1].value < target) {
      items[min(prev + step, n) - 1].isActive = true;
      await refresh();
      await Future.delayed(delay);

      items[min(prev + step, n) - 1].isActive = false;
      prev += step;
    }

    for (int i = prev; i < min(prev + step, n); i++) {
      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[i].value == target) {
        items[i].isFound = true;
        await refresh();
        return;
      }

      items[i].isActive = false;
    }
  }

  @override
  bool get requiresSorted => true;
}
