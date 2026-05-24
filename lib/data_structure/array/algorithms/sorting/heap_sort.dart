import 'package:algov/data_structure/array/models/sort_item.dart';

class HeapSort implements SortingAlgorithm {
  @override
  String get name => "Heap Sort";
  @override
  String get id => "Heap";

  @override
  String get description =>
      "Builds a max heap and repeatedly extracts the maximum "
      "element to sort the array.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int n = items.length;

    onExplain("Building max heap");

    // 🔹 Build max heap
    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      await _heapify(items, n, i, refresh, delay, onExplain);
    }

    onExplain("Max heap built");

    // 🔹 Extract elements from heap
    for (int i = n - 1; i > 0; i--) {
      onExplain("Swapping root ${items[0].value} with ${items[i].value}");

      final temp = items[0];
      items[0] = items[i];
      items[i] = temp;

      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);
      items[i].isActive = false;

      await _heapify(items, i, 0, refresh, delay, onExplain);
    }

    onExplain("Heap Sort completed");
  }

  Future<void> _heapify(
    List<SortItem> items,
    int heapSize,
    int root,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int largest = root;
    int left = 2 * root + 1;
    int right = 2 * root + 2;

    if (left < heapSize) {
      onExplain(
        "Comparing parent ${items[largest].value} "
        "with left child ${items[left].value}",
      );

      items[left].isActive = true;
      items[largest].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[left].value > items[largest].value) {
        largest = left;
      }

      items[left].isActive = false;
      items[root].isActive = false;
    }

    if (right < heapSize) {
      onExplain(
        "Comparing current largest ${items[largest].value} "
        "with right child ${items[right].value}",
      );

      items[right].isActive = true;
      items[largest].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[right].value > items[largest].value) {
        largest = right;
      }

      items[right].isActive = false;
      items[root].isActive = false;
    }

    if (largest != root) {
      onExplain("Swapping ${items[root].value} with ${items[largest].value}");

      final swap = items[root];
      items[root] = items[largest];
      items[largest] = swap;

      await refresh();
      await Future.delayed(delay);

      await _heapify(items, heapSize, largest, refresh, delay, onExplain);
    }
  }
}
