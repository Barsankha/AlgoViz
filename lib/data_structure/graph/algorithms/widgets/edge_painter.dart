import 'dart:math';

import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/graph/models/edge_models.dart';
import 'package:algov/data_structure/graph/models/node_model.dart';
import 'package:flutter/material.dart';

class EdgePainter extends CustomPainter {
  final Map<String, NodeModel> nodes;
  final Map<String, EdgeModel> edges;

  EdgePainter({required this.nodes, required this.edges});

  @override
  void paint(Canvas canvas, Size size) {
    for (final edge in edges.values) {
      final fromNode = nodes[edge.from];
      final toNode = nodes[edge.to];

      if (fromNode == null || toNode == null) continue;

      final paint =
          Paint()
            ..color = _edgeColor(edge.state)
            ..strokeWidth = _edgeWidth(edge.state)
            ..style = PaintingStyle.stroke;

      final p1 = fromNode.position;
      final p2 = toNode.position;

      final dx = p2.dx - p1.dx;
      final dy = p2.dy - p1.dy;

      final angle = atan2(dy, dx);

      final midPoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
      // Unit normal vector
      final normal = Offset(-sin(angle), cos(angle));
      final edgeLength = (p2 - p1).distance;

      double textOffset;
      if (edgeLength < 0.2) {
        textOffset = 18; // short edges → push more
      } else {
        textOffset = 12;
      }

      final textPosition = midPoint + normal * textOffset;

      const nodeRadius = 16.0;
      const arrowSize = 0.0;

      final arrowTip = Offset(
        p2.dx - nodeRadius * cos(angle),
        p2.dy - nodeRadius * sin(angle),
      );

      final arrowBase = Offset(
        arrowTip.dx - arrowSize * cos(angle),
        arrowTip.dy - arrowSize * sin(angle),
      );

      // Edge line stops at arrow base
      canvas.drawLine(fromNode.position, arrowBase, paint);

      // Optional: arrow for directed graphs
      if (edge.directed) {
        _drawArrowHead(canvas, paint, arrowTip, angle);
      }
      final w = edge.weight;
      if (w != 1.0) {
        _drawWeight(canvas, w, textPosition, paint.color);
      }
    }
  } //

  Color _edgeColor(EdgeState state) {
    switch (state) {
      case EdgeState.exploring:
        return Colors.orange;
      case EdgeState.selected:
        return Colors.deepPurpleAccent;
      default:
        return Colors.grey.shade400;
    }
  }

  double _edgeWidth(EdgeState state) {
    switch (state) {
      case EdgeState.exploring:
        return 3;
      case EdgeState.selected:
        return 4;
      default:
        return 2;
    }
  }

  void _drawArrowHead(Canvas canvas, Paint paint, Offset tip, double angle) {
    const arrowSize = 10.0;

    final p1 = Offset(
      tip.dx - arrowSize * cos(angle - pi / 6),
      tip.dy - arrowSize * sin(angle - pi / 6),
    );

    final p2 = Offset(
      tip.dx - arrowSize * cos(angle + pi / 6),
      tip.dy - arrowSize * sin(angle + pi / 6),
    );

    canvas.drawLine(tip, p1, paint);
    canvas.drawLine(tip, p2, paint);
  }

  void _drawWeight(Canvas canvas, double weight, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: weight.toString().replaceAll(".0", ""),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    // Center text
    final offset =
        position - Offset(textPainter.width / 2, textPainter.height / 2);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant EdgePainter oldDelegate) {
    return true;
  }
}
