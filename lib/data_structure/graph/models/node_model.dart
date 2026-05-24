import 'dart:ui';

import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';

class NodeModel implements Algo {
  final String id;
  final String label;

  /// Layout position (computed by LayoutEngine)
  final Offset position;

  /// Visual state
  final NodeState state;

  /// Extra metadata (distance, depth, etc.)
  final Map<String, dynamic> meta;
  final int? groupId;
  final bool highlighted;
  final int? sccId;

  const NodeModel({
    required this.id,
    required this.label,
    required this.position,
    this.state = NodeState.unvisited,
    this.meta = const {},
    this.groupId,
    this.highlighted = false,
    this.sccId,
  });

  NodeModel copyWith({
    Offset? position,
    NodeState? state,
    Map<String, dynamic>? meta,
    int? groupId,
    bool? highlighted,
    int? sccId,
  }) {
    return NodeModel(
      id: id,
      label: label,
      position: position ?? this.position,
      state: state ?? this.state,
      meta: meta != null ? {...this.meta, ...meta} : this.meta,
      groupId: groupId ?? this.groupId,
      highlighted: highlighted ?? this.highlighted,
      sccId: sccId ?? this.sccId,
    );
  }

  @override
  String get name => "Graph";
}
