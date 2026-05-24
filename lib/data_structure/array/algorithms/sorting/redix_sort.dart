import 'package:algov/data_structure/array/models/sort_item.dart';

class RadixSort implements SortingAlgorithm {
  @override
  String get name => "Radix Sort";
  @override
  String get id => "Radix";

  @override
  String get description =>
      "A non-comparison sort that processes numbers digit by digit "
      "using counting sort as a subroutine.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int maxValue = items.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    for (int exp = 1; maxValue ~/ exp > 0; exp *= 10) {
      onExplain("Sorting by digit at place $exp");

      await _countingSortByDigit(items, exp, refresh, delay, onExplain);
    }

    onExplain("Radix Sort completed");
  }

  Future<void> _countingSortByDigit(
    List<SortItem> items,
    int exp,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int n = items.length;
    List<SortItem> output = List.generate(n, (index) => items[index]);
    List<int> count = List.filled(10, 0);

    // 🔹 Count occurrences
    for (int i = 0; i < n; i++) {
      int digit = (items[i].value ~/ exp) % 10;
      count[digit]++;

      items[i].isActive = true;
      onExplain("Counting digit $digit from ${items[i].value}");
      await refresh();
      await Future.delayed(delay);
      items[i].isActive = false;
    }

    // 🔹 Cumulative count
    for (int i = 1; i < 10; i++) {
      count[i] += count[i - 1];
    }

    // 🔹 Build output array (stable)
    for (int i = n - 1; i >= 0; i--) {
      int digit = (items[i].value ~/ exp) % 10;
      output[count[digit] - 1] = items[i];
      count[digit]--;

      onExplain("Placing ${items[i].value} in position ${count[digit] + 1}");
      await refresh();
      await Future.delayed(delay);
    }

    // 🔹 Copy back
    for (int i = 0; i < n; i++) {
      items[i] = output[i];
      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);
      items[i].isActive = false;
    }
  }
}
