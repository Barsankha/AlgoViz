import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';

class EdgeModel implements Algo {
  final String id;
  final String from;
  final String to;

  final bool directed;
  final double weight;

  final EdgeState state;

  const EdgeModel({
    required this.id,
    required this.from,
    required this.to,
    this.directed = false,
    this.weight = 1.0,
    this.state = EdgeState.normal,
  });

  EdgeModel copyWith({EdgeState? state}) {
    return EdgeModel(
      id: id,
      from: from,
      to: to,
      directed: directed,
      weight: weight,
      state: state ?? this.state,
    );
  }

  @override
  String get name => "Graph";
}
