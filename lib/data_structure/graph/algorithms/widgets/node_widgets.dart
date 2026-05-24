import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  final NodeModel node;

  const NodeWidget({super.key, required this.node});

  Color get color {
    switch (node.state) {
      case NodeState.current:
        return Colors.cyanAccent;
      case NodeState.discovered:
        return Colors.orangeAccent;
      case NodeState.visited:
        return Colors.greenAccent;
      case NodeState.path:
        return Colors.purple;
      case NodeState.error:
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      //duration: const Duration(milliseconds: 300),
      width: 25,
      height: 25,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      alignment: Alignment.center,
      child: Text(node.label, style: const TextStyle(color: Colors.black)),
    );
  }
}
