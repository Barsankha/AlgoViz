import 'dart:math';

import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';

class FibonacciSearch implements SearchingAlgorithm {
  @override
  String get name => "Fibonacci Search";

  @override
  Future<void> search(
    List<SearchItem> items,
    Future<void> Function() refresh,
    Duration delay,
    SearchAlgoController controller,
    int target,
  ) async {
    int n = items.length;

    int fibMm2 = 0;
    int fibMm1 = 1;
    int fibM = fibMm1 + fibMm2;

    while (fibM < n) {
      fibMm2 = fibMm1;
      fibMm1 = fibM;
      fibM = fibMm1 + fibMm2;
    }

    int offset = -1;

    while (fibM > 1) {
      int i = min(offset + fibMm2, n - 1);

      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[i].value == target) {
        items[i].isFound = true;
        await refresh();
        return;
      }

      items[i].isActive = false;

      if (items[i].value < target) {
        fibM = fibMm1;
        fibMm1 = fibMm2;
        fibMm2 = fibM - fibMm1;
        offset = i;
      } else {
        fibM = fibMm2;
        fibMm1 -= fibMm2;
        fibMm2 = fibM - fibMm1;
      }
    }

    if (fibMm1 == 1 && offset + 1 < n && items[offset + 1].value == target) {
      items[offset + 1].isFound = true;
      await refresh();
    }
  }

  @override
  bool get requiresSorted => true;
}
