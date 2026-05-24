import 'package:algov/data_structure/graph/algorithms/widgets/edge_painter.dart';
import 'package:algov/data_structure/graph/algorithms/widgets/node_widgets.dart';
import 'package:algov/data_structure/linked_list/models/linked_list_model.dart';
import 'package:flutter/material.dart';

class LinkedListGraphVisualization extends StatelessWidget {
  final VisualLinkedList vll;
  final double totalWidth;
  final double height;
  final bool isDark;
  final bool isCompact;

  const LinkedListGraphVisualization({
    super.key,
    required this.vll,
    required this.totalWidth,
    required this.height,
    required this.isDark,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    //const double centerY = 200.0;
    const double nodeRadius = 15.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            painter: EdgePainter(nodes: vll.nodes, edges: vll.edges),
            size: Size(totalWidth, height),
          ),
          ...vll.nodes.entries.map((entry) {
            final node = entry.value;
            final widget =
                node.id == 'head' || node.id == 'null'
                    ? NodeWidget(node: node)
                    : NodeWidget(node: node);
            return Positioned(
              left: node.position.dx - nodeRadius,
              top: node.position.dy - nodeRadius,
              child: widget,
            );
          }),
        ],
      ),
    );
  }
}
