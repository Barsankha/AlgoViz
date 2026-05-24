class SortItem {
  int value;
  bool isActive;

  SortItem(this.value, {this.isActive = false});
}

abstract class Algo {
  String get name;
}

//sort
abstract class SortingAlgorithm implements Algo {
  String get id;
  @override
  String get name;
  String get description;

  Future<void> sort(
    List<SortItem> items,
    Future<void> Function() refresh,
    Duration delay,
    void Function(String explanation) onExplain,
  );
} //

//search

class PseudoCodeLine {
  final int line;
  final String code;

  PseudoCodeLine(this.line, this.code);
}

class SortStep {
  final List<SortItem> snapshot;
  final String explanation;
  //final int pseudoLine;

  SortStep(
    this.snapshot,
    this.explanation,
    //this.pseudoLine,
  );
}
