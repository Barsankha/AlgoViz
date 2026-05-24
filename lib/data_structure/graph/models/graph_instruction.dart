import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/enums/graph_phases.dart';

class AlgoInstruction {
  final AlgoPhase phase;
  final AlgoOp op;
  final String? target; // node, edge, set
  final Map<String, dynamic> args;

  const AlgoInstruction({
    required this.phase,
    required this.op,
    this.target,
    this.args = const {},
  });
}

abstract class AlgorithmMeta {
  GraphAlgoType get type;
  String get name;

  /// Pure logic description (no graph state)
  List<AlgoInstruction> get instructions;
}
