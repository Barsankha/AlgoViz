import 'package:algov/data_structure/array/models/sort_item.dart';

class MergeSort implements SortingAlgorithm {
  @override
  String get id => "Merge";

  @override
  String get name => "Merge Sort";

  @override
  String get description =>
      "Divides the array into halves, sorts them recursively, "
      "and then merges the sorted halves.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    await _mergeSort(items, 0, items.length - 1, refresh, delay, onExplain);
    onExplain("Merge Sort completed");
  }

  Future<void> _mergeSort(
    List<SortItem> items,
    int left,
    int right,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    if (left >= right) return;

    int mid = (left + right) ~/ 2;

    onExplain("Dividing array from index $left to $right");

    await _mergeSort(items, left, mid, refresh, delay, onExplain);
    await _mergeSort(items, mid + 1, right, refresh, delay, onExplain);

    await _merge(items, left, mid, right, refresh, delay, onExplain);
  }

  Future<void> _merge(
    List<SortItem> items,
    int left,
    int mid,
    int right,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    List<int> temp = [];
    int i = left, j = mid + 1;

    onExplain("Merging subarrays [$left..$mid] and [$mid+1..$right]");

    while (i <= mid && j <= right) {
      items[i].isActive = true;
      items[j].isActive = true;
      await refresh();
      await Future.delayed(delay);

      if (items[i].value <= items[j].value) {
        temp.add(items[i].value);
        items[i].isActive = false;
        i++;
      } else {
        temp.add(items[j].value);
        items[j].isActive = false;
        j++;
      }
    }

    while (i <= mid) {
      temp.add(items[i].value);
      i++;
    }

    while (j <= right) {
      temp.add(items[j].value);
      j++;
    }

    for (int k = 0; k < temp.length; k++) {
      items[left + k].value = temp[k];
      await refresh();
      await Future.delayed(delay);

      onExplain("Placing ${temp[k]} at position ${left + k}");
    }
  }
}
