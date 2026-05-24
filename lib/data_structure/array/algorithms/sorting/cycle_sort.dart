import 'package:algov/data_structure/array/models/sort_item.dart';

class CycleSort implements SortingAlgorithm {
  @override
  String get name => "Cycle Sort";
  @override
  String get id => "Cycle";

  @override
  String get description =>
      "Places each element directly into its correct position, "
      "minimizing the number of writes.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int n = items.length;

    for (int cycleStart = 0; cycleStart < n - 1; cycleStart++) {
      int item = items[cycleStart].value;
      int pos = cycleStart;
      await refresh();
      onExplain("Starting cycle at index $cycleStart with value $item");

      // Find position where we put the item
      for (int i = cycleStart + 1; i < n; i++) {
        if (items[i].value < item) {
          pos++;
        }
      }

      // If item is already in correct position
      if (pos == cycleStart) {
        onExplain("Value $item is already in correct position");
        continue;
      }

      // Skip duplicates
      while (item == items[pos].value) {
        pos++;
      }

      onExplain("Placing $item at index $pos");

      // Put the item to its right position
      int temp = items[pos].value;
      items[pos].value = item;
      item = temp;

      items[pos].isActive = true;
      await refresh();
      await Future.delayed(delay);
      items[pos].isActive = false;

      // Rotate the rest of the cycle
      while (pos != cycleStart) {
        pos = cycleStart;

        for (int i = cycleStart + 1; i < n; i++) {
          if (items[i].value < item) {
            pos++;
          }
        }

        while (item == items[pos].value) {
          pos++;
        }

        onExplain("Rotating cycle: placing $item at index $pos");

        temp = items[pos].value;
        items[pos].value = item;
        item = temp;

        items[pos].isActive = true;
        await refresh();
        await Future.delayed(delay);
        items[pos].isActive = false;
      }

      onExplain("Cycle starting at index $cycleStart completed");
    }

    onExplain("Cycle Sort completed");
  }
}
