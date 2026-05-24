import 'package:algov/data_structure/array/models/sort_item.dart';

class CountingSort implements SortingAlgorithm {
  @override
  String get name => "Counting Sort";
  @override
  String get id => "Counting";

  @override
  String get description =>
      "Counts the frequency of each element and uses those counts "
      "to place elements in sorted order.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    if (items.isEmpty) return;

    int maxValue = items.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    onExplain("Finding maximum value: $maxValue");
    await refresh();
    await Future.delayed(delay);

    List<int> count = List.filled(maxValue + 1, 0);

    // 🔹 Step 1: Count occurrences
    onExplain("Counting occurrences of each element");

    for (var item in items) {
      item.isActive = true;
      await refresh();
      await Future.delayed(delay);

      count[item.value]++;
      onExplain("Increment count of ${item.value}");

      item.isActive = false;
      await refresh();
    }

    // 🔹 Step 2: Build sorted array
    int index = 0;
    onExplain("Placing elements back in sorted order");

    for (int value = 0; value <= maxValue; value++) {
      while (count[value] > 0) {
        onExplain("Placing $value at index $index");

        items[index].value = value;
        items[index].isActive = true;

        await refresh();
        await Future.delayed(delay);

        items[index].isActive = false;
        index++;
        count[value]--;
      }
    }

    onExplain("Counting Sort completed");
  }
}
