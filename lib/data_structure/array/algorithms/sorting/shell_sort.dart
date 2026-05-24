import 'package:algov/data_structure/array/models/sort_item.dart';

class ShellSort implements SortingAlgorithm {
  @override
  String get name => "Shell Sort";
  @override
  String get id => "Shell";

  @override
  String get description =>
      "An optimization of insertion sort that allows the exchange "
      "of items that are far apart using decreasing gaps.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int n = items.length;

    // 🔹 Start with large gap, reduce each time
    for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
      onExplain("Starting gap = $gap");

      for (int i = gap; i < n; i++) {
        SortItem temp = items[i];
        int j = i;

        onExplain("Inserting ${temp.value} with gap $gap");

        items[i].isActive = true;
        await refresh();
        await Future.delayed(delay);

        while (j >= gap && items[j - gap].value > temp.value) {
          onExplain("Shifting ${items[j - gap].value} to position $j");

          items[j] = items[j - gap];

          items[j].isActive = true;
          await refresh();
          await Future.delayed(delay);

          items[j].isActive = false;
          j -= gap;
        }

        items[j] = temp;

        await refresh();
        await Future.delayed(delay);

        items[i].isActive = false;
      }
    }

    onExplain("Shell Sort completed");
  }
}
