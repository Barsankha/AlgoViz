import 'package:algov/data_structure/array/models/sort_item.dart';

class InsertionSort implements SortingAlgorithm {
  @override
  String get id => "Insertion";
  @override
  String get name => "Insertion Sort";

  @override
  String get description =>
      "Builds the sorted array one element at a time by inserting "
      "each element into its correct position.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int n = items.length;

    for (int i = 1; i < n; i++) {
      int key = items[i].value;
      int j = i - 1;

      onExplain("Picking ${items[i].value} to insert into sorted part");

      items[i].isActive = true;
      await refresh();
      await Future.delayed(delay);

      while (j >= 0 && items[j].value > key) {
        onExplain(
          "Since ${items[j].value} > $key, shifting ${items[j].value} right",
        );

        items[j].isActive = true;
        await refresh();
        await Future.delayed(delay);

        items[j + 1].value = items[j].value;
        await refresh();
        await Future.delayed(delay);

        items[j].isActive = false;
        j--;
      }

      items[j + 1].value = key;

      onExplain("Inserted $key at correct position");

      items[i].isActive = false;
      await refresh();
      await Future.delayed(delay);
    }

    onExplain("Insertion Sort completed");
  }
}
