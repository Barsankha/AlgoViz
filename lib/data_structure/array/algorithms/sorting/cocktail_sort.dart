import 'package:algov/data_structure/array/models/sort_item.dart';

class CocktailSort implements SortingAlgorithm {
  @override
  String get name => "Cocktail Sort";
  @override
  String get id => "Cocktail";

  @override
  String get description =>
      "A variation of Bubble Sort that traverses the list in both "
      "directions alternately.";

  @override
  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  ) async {
    int start = 0;
    int end = items.length - 1;
    bool swapped = true;

    while (swapped) {
      swapped = false;
      await refresh();
      onExplain("Forward pass: moving largest element to the right");

      // 🔹 Forward pass
      for (int i = start; i < end; i++) {
        onExplain("Comparing ${items[i].value} and ${items[i + 1].value}");

        items[i].isActive = true;
        items[i + 1].isActive = true;
        await refresh();
        await Future.delayed(delay);

        if (items[i].value > items[i + 1].value) {
          onExplain("Swapping ${items[i].value} and ${items[i + 1].value}");

          final temp = items[i];
          items[i] = items[i + 1];
          items[i + 1] = temp;

          swapped = true;
          await refresh();
          await Future.delayed(delay);
        }

        items[i].isActive = false;
        items[i + 1].isActive = false;
      }

      if (!swapped) break;

      end--;
      swapped = false;
      await refresh();
      onExplain("Backward pass: moving smallest element to the left");

      // 🔹 Backward pass
      for (int i = end; i > start; i--) {
        onExplain("Comparing ${items[i - 1].value} and ${items[i].value}");

        items[i - 1].isActive = true;
        items[i].isActive = true;
        await refresh();
        await Future.delayed(delay);

        if (items[i - 1].value > items[i].value) {
          onExplain("Swapping ${items[i - 1].value} and ${items[i].value}");

          final temp = items[i - 1];
          items[i - 1] = items[i];
          items[i] = temp;

          swapped = true;
          await refresh();
          await Future.delayed(delay);
        }

        items[i - 1].isActive = false;
        items[i].isActive = false;
      }

      start++;
    }

    onExplain("Cocktail Sort completed");
  }
}
