import 'dart:math';

import 'package:algov/data_structure/array/models/sort_item.dart';

class BucketSort implements SortingAlgorithm {
  @override
  String get name => "Bucket Sort";
  @override
  String get id => "Bucket";

  @override
  String get description =>
      "A distribution-based sorting algorithm that divides elements "
      "into buckets, sorts each bucket, and then merges them.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int n = items.length;
    if (n == 0) return;

    int minValue = items.map((e) => e.value).reduce((a, b) => a < b ? a : b);

    int maxValue = items.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    int bucketCount = (sqrt(n)).floor() + 1;
    await refresh();

    onExplain("Creating $bucketCount buckets");

    List<List<SortItem>> buckets = List.generate(bucketCount, (_) => []);

    // 🔹 Distribute elements into buckets
    for (int i = 0; i < n; i++) {
      int index =
          ((items[i].value - minValue) *
              bucketCount ~/
              (maxValue - minValue + 1));

      onExplain("Placing ${items[i].value} into bucket $index");

      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);

      buckets[index].add(items[i]);
      items[i].isActive = false;
    }

    // 🔹 Sort individual buckets (Insertion Sort)
    int k = 0;
    for (int i = 0; i < bucketCount; i++) {
      if (buckets[i].isNotEmpty) {
        onExplain("Sorting bucket $i");

        buckets[i].sort((a, b) => a.value.compareTo(b.value));

        for (var item in buckets[i]) {
          items[k++] = item;

          item.isActive = true;
          await refresh();
          await Future.delayed(delay);
          item.isActive = false;
        }
      }
    }

    onExplain("Bucket Sort completed");
  }
}
