import 'package:algov/data_structure/array/models/sort_item.dart';

class TimSort implements SortingAlgorithm {
  static const int run = 32;

  @override
  String get name => "Tim Sort";
  @override
  String get id => "Tim";

  @override
  String get description =>
      "A hybrid sorting algorithm that uses insertion sort for small runs "
      "and merge sort to combine them efficiently.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int n = items.length;

    onExplain("Dividing array into runs of size $run");

    // 🔹 Step 1: Sort individual runs using Insertion Sort
    for (int i = 0; i < n; i += run) {
      await _insertionSort(
        items,
        i,
        (i + run - 1 < n) ? i + run - 1 : n - 1,
        refresh,
        delay,
        onExplain,
      );
    }

    // 🔹 Step 2: Merge runs
    for (int size = run; size < n; size *= 2) {
      onExplain("Merging runs of size $size");

      for (int left = 0; left < n; left += 2 * size) {
        int mid = left + size - 1;
        int right = (left + 2 * size - 1 < n) ? left + 2 * size - 1 : n - 1;

        if (mid < right) {
          await _merge(items, left, mid, right, refresh, delay, onExplain);
        }
      }
    }

    onExplain("Tim Sort completed");
  }

  // 🔹 Insertion Sort for small runs
  Future<void> _insertionSort(
    List<SortItem> items,
    int left,
    int right,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    for (int i = left + 1; i <= right; i++) {
      SortItem temp = items[i];
      int j = i - 1;

      onExplain("Insertion sorting ${temp.value}");

      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);

      while (j >= left && items[j].value > temp.value) {
        items[j + 1] = items[j];

        onExplain("Shifting ${items[j].value} to position ${j + 1}");

        items[j + 1].isActive = true;
        await refresh();
        await Future.delayed(delay);

        items[j + 1].isActive = false;
        j--;
      }

      items[j + 1] = temp;

      await refresh();
      await Future.delayed(delay);

      items[i].isActive = false;
    }
  }

  // 🔹 Merge two sorted runs
  Future<void> _merge(
    List<SortItem> items,
    int left,
    int mid,
    int right,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int len1 = mid - left + 1;
    int len2 = right - mid;

    List<SortItem> leftArr = List.generate(len1, (i) => items[left + i]);
    List<SortItem> rightArr = List.generate(len2, (i) => items[mid + 1 + i]);

    int i = 0, j = 0, k = left;

    onExplain("Merging two sorted runs");

    while (i < len1 && j < len2) {
      if (leftArr[i].value <= rightArr[j].value) {
        items[k++] = leftArr[i++];
      } else {
        items[k++] = rightArr[j++];
      }

      await refresh();
      await Future.delayed(delay);
    }

    while (i < len1) {
      items[k++] = leftArr[i++];
      await refresh();
      await Future.delayed(delay);
    }

    while (j < len2) {
      items[k++] = rightArr[j++];
      await refresh();
      await Future.delayed(delay);
    }
  }
}
