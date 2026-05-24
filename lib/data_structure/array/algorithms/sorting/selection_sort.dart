import 'package:algov/data_structure/array/models/sort_item.dart';

class SelectionSort implements SortingAlgorithm {
  @override
  String get id => "Selection";

  @override
  String get name => "Selection Sort";

  @override
  String get description =>
      "Repeatedly selects the minimum element from the unsorted part "
      "and moves it to the beginning.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String) onExplain,
  ) async {
    int n = items.length;

    for (int i = 0; i < n - 1; i++) {
      int minIndex = i;
      onExplain(
        "Starting pass ${i + 1}. Assuming ${items[i].value} is minimun",
      );

      items[minIndex].isActive = true;
      await refresh();
      await Future.delayed(delay);

      for (int j = i + 1; j < n; j++) {
        onExplain(
          "Comparing current minimum ${items[minIndex].value} "
          "with ${items[j].value}",
        );
        items[j].isActive = true;
        await refresh();
        await Future.delayed(delay);

        if (items[j].value < items[minIndex].value) {
          items[minIndex].isActive = false;
          minIndex = j;
          onExplain(
            "New minimum found: ${items[minIndex].value} at index $minIndex",
          );

          items[minIndex].isActive = true;
          await refresh();
          await Future.delayed(delay);
        } else {
          items[j].isActive = false;
        }
      }

      if (minIndex != i) {
        onExplain("Swapping ${items[i].value} and ${items[minIndex].value}");

        final temp = items[i];
        items[i] = items[minIndex];
        items[minIndex] = temp;

        await refresh();
        await Future.delayed(delay);
      }

      items[i].isActive = false;
      items[minIndex].isActive = false;
      onExplain("Position $i fixed with value ${items[i].value}");
    }

    onExplain("Selection Sort completed");
  }
}
