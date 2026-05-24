import 'dart:math';
import 'package:algov/data_structure/array/models/sort_item.dart';

class IntroSort implements SortingAlgorithm {
  @override
  String get name => "Intro Sort";
  @override
  String get id => "Intro";

  @override
  String get description =>
      "A hybrid sorting algorithm that starts with Quick Sort "
      "and switches to Heap Sort to avoid worst-case performance.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int maxDepth = (log(items.length) / log(2)).floor() * 2;

    onExplain("Starting Intro Sort with depth limit $maxDepth");

    await _introSort(
      items,
      0,
      items.length - 1,
      maxDepth,
      refresh,
      delay,
      onExplain,
    );

    onExplain("Intro Sort completed");
  }

  Future<void> _introSort(
    List<SortItem> items,
    int low,
    int high,
    int depthLimit,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    if (low >= high) return;

    if (depthLimit == 0) {
      onExplain(
        "Depth limit reached — switching to Heap Sort for range [$low..$high]",
      );

      await _heapSortRange(items, low, high, refresh, delay, onExplain);
      return;
    }

    int pivotIndex = await _partition(
      items,
      low,
      high,
      refresh,
      delay,
      onExplain,
    );

    await _introSort(
      items,
      low,
      pivotIndex - 1,
      depthLimit - 1,
      refresh,
      delay,
      onExplain,
    );

    await _introSort(
      items,
      pivotIndex + 1,
      high,
      depthLimit - 1,
      refresh,
      delay,
      onExplain,
    );
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

    onExplain("Choosing pivot $pivot");

    items[high].isActive = true;
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

        final temp = items[i];
        items[i] = items[j];
        items[j] = temp;

        onExplain("Swapping ${items[i].value} and ${items[j].value}");
        await refresh();
        await Future.delayed(delay);
      }

      items[j].isActive = false;
    }

    final temp = items[i + 1];
    items[i + 1] = items[high];
    items[high] = temp;

    items[high].isActive = false;
    await refresh();
    await Future.delayed(delay);

    return i + 1;
  }

  // 🔹 Heap Sort on sub-array
  Future<void> _heapSortRange(
    List<SortItem> items,
    int start,
    int end,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int n = end - start + 1;

    for (int i = start + n ~/ 2 - 1; i >= start; i--) {
      await _heapify(items, n, i, start, refresh, delay, onExplain);
    }

    for (int i = end; i > start; i--) {
      final temp = items[start];
      items[start] = items[i];
      items[i] = temp;

      onExplain("Heap extract: moving max to position $i");
      await refresh();
      await Future.delayed(delay);

      await _heapify(items, i - start, start, start, refresh, delay, onExplain);
    }
  }

  Future<void> _heapify(
    List<SortItem> items,
    int heapSize,
    int root,
    int offset,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int largest = root;
    int left = offset + 2 * (root - offset) + 1;
    int right = offset + 2 * (root - offset) + 2;

    if (left < offset + heapSize && items[left].value > items[largest].value) {
      largest = left;
    }

    if (right < offset + heapSize &&
        items[right].value > items[largest].value) {
      largest = right;
    }

    if (largest != root) {
      final swap = items[root];
      items[root] = items[largest];
      items[largest] = swap;

      onExplain(
        "Heapify swap ${items[largest].value} and ${items[root].value}",
      );

      await refresh();
      await Future.delayed(delay);

      await _heapify(
        items,
        heapSize,
        largest,
        offset,
        refresh,
        delay,
        onExplain,
      );
    }
  }
}
