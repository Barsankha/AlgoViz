import 'package:algov/data_structure/array/models/sort_item.dart';

//
class BubbleSort implements SortingAlgorithm {
  @override
  String get id => "bubble";

  @override
  String get name => "Bubble Sort";

  @override
  String get description =>
      "Repeatedly compares adjacent elements and swaps them if needed.";
  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String) onExplain,
  ) async {
    for (int i = 0; i < items.length; i++) {
      onExplain("Starting pass ${i + 1}");
      await refresh();

      for (int j = 0; j < items.length - i - 1; j++) {
        onExplain("Comparing ${items[j].value} and ${items[j + 1].value}");

        items[j].isActive = true;
        items[j + 1].isActive = true;
        await refresh();
        await Future.delayed(delay);

        if (items[j].value > items[j + 1].value) {
          onExplain("Swapping ${items[j].value} and ${items[j + 1].value}");
          final temp = items[j];
          items[j] = items[j + 1];
          items[j + 1] = temp;
          await refresh();
          await Future.delayed(delay);
        }

        items[j].isActive = false;
        items[j + 1].isActive = false;
      }
    }
  }

  // @override
  // List<String> get complexity => ["","",""];

  // @override
  // Color get complexityColor => Colors.redAccent;

  // @override
  // List<String> get cons => con;

  // @override
  // Icon get icon => Icon(Icons.bubble_chart);

  // @override
  // List<String> get pros =>pro ;

  // @override
  // List<String> get usecases => ;

  // @override
  // String get description => bubblesortDes;
}

const String bubblesortDes =
    "Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in the wrong order.This algorithm is not efficient for large data sets as its average and worst-case time complexity are quite high";
const List<String> con = [
  "Bubble sort has a time complexity of O(n2) which makes it very slow for large data sets.",
  "Bubble sort has almost no or limited real world applications. It is mostly used in academics to teach different ways of sorting.",
];
const List<String> pro = [
  "Bubble sort is easy to understand and implement.",
  "It does not require any additional memory space.",
  "It is a stable sorting algorithm, meaning that elements with the same key value maintain their relative order in the sorted output.",
];
const List<String> use = ["", ""];
