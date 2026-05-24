import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:flutter/material.dart';

class BuildLegend extends StatelessWidget {
  final bool isCompact;
  final VisualController controller;
  final bool isdark;
  const BuildLegend({
    super.key,
    required this.isCompact,
    required this.controller,
    required this.isdark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LegendItem(
          label: labelText(controller),
          color: Colors.greenAccent,
          isCompact: isCompact,
          isdark: isdark,
        ),
        SizedBox(width: isCompact ? 12 : 16),
        LegendItem(
          label: "Comparing",
          color: Colors.orangeAccent,
          isCompact: isCompact,
          isdark: isdark,
        ),
        SizedBox(width: isCompact ? 12 : 16),
        LegendItem(
          label: "Active",
          color: Colors.cyan,
          isCompact: isCompact,
          isdark: isdark,
        ),
      ],
    );
  }
}

String labelText(VisualController controller) {
  if (controller.type == "Sort") {
    return "Sorted";
  } else if (controller.type == "Search") {
    return "Found";
  } else {
    return "Visited";
  }
}

class LegendItem extends StatelessWidget {
  final bool isCompact;
  final Color color;
  final String label;
  final bool isdark;
  const LegendItem({
    super.key,
    required this.isCompact,
    required this.color,
    required this.label,
    required this.isdark,
  });

  @override
  Widget build(BuildContext context) {
    final Color textcolor = isdark ? Colors.white70 : Colors.black;
    return Row(
      children: [
        Container(
          width: isCompact ? 6 : 8,
          height: isCompact ? 6 : 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: isCompact ? 4 : 6),
        Text(
          label,
          style: TextStyle(
            fontSize: isCompact ? 11 : 12,
            color: textcolor, // Colors.white70,
          ),
        ),
      ],
    );
  }
}
