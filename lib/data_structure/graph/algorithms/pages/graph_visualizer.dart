import 'package:algov/data_structure/graph/algorithms/widgets/edge_painter.dart';
import 'package:algov/data_structure/graph/algorithms/widgets/node_widgets.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:flutter/material.dart';

///
////

class GraphVisulazionGrid extends StatelessWidget {
  final bool isCompact;
  final dynamic controller;
  final bool isDark;
  const GraphVisulazionGrid({
    super.key,
    required this.isCompact,
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final step = controller.currentStep;
        return GraphVisualizer(step: step);
      },
    );
  }
}

class GraphVisualizer extends StatelessWidget {
  final GraphStep step;

  const GraphVisualizer({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        Offset toScreen(Offset norm) {
          return Offset(norm.dx * w, norm.dy * h);
        }

        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            RepaintBoundary(
              child: CustomPaint(
                size: size,
                painter: EdgePainter(
                  nodes: step.nodes.map(
                    (k, v) =>
                        MapEntry(k, v.copyWith(position: toScreen(v.position))),
                  ),
                  edges: step.edges,
                ),
              ),
            ),
            ...step.nodes.values.map((node) {
              final pos = toScreen(node.position);
              return Positioned(
                left: pos.dx - 13,
                top: pos.dy - 13,
                child: NodeWidget(node: node),
              );
            }),
          ],
        );
      },
    );
  }
}
