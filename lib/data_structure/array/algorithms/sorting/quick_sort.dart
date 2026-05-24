import 'package:algov/data_structure/array/models/sort_item.dart';

class QuickSort implements SortingAlgorithm {
  @override
  String get name => "Quick Sort";
  @override
  String get id => "Quick";

  @override
  String get description =>
      "Selects a pivot element and partitions the array such that "
      "elements smaller than pivot come before it and larger ones after.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    await _quickSort(items, 0, items.length - 1, refresh, delay, onExplain);
    onExplain("Quick Sort completed");
  }

  Future<void> _quickSort(
    List<SortItem> items,
    int low,
    int high,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    if (low < high) {
      int pivotIndex = await _partition(
        items,
        low,
        high,
        refresh,
        delay,
        onExplain,
      );

      await _quickSort(items, low, pivotIndex - 1, refresh, delay, onExplain);
      await _quickSort(items, pivotIndex + 1, high, refresh, delay, onExplain);
    }
  }

  Future<int> _partition(
    List<SortItem> items,
    int low,
    int high,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int pivot = items[high].value;

    onExplain("Choosing pivot: $pivot");

    items[high].isActive = true; // Pivot highlight
    await refresh();
    await Future.delayed(delay);

    int i = low - 1;

    for (int j = low; j < high; j++) {
      onExplain("Comparing ${items[j].value} with pivot $pivot");

      items[j].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[j].value < pivot) {
        i++;

        onExplain(
          "Since ${items[j].value} < $pivot, swapping with ${items[i].value}",
        );

        final temp = items[i];
        items[i] = items[j];
        items[j] = temp;

        await refresh();
        await Future.delayed(delay);
      }

      items[j].isActive = false;
    }

    onExplain("Placing pivot $pivot at correct position");

    final temp = items[i + 1];
    items[i + 1] = items[high];
    items[high] = temp;

    items[high].isActive = false;
    await refresh();
    await Future.delayed(delay);

    return i + 1;
  }
}
