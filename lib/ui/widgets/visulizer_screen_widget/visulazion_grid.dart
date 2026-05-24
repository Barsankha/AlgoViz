import 'package:flutter/material.dart';

class CustomVisualizer extends StatelessWidget {
  final bool isCompact;
  final bool isdark;
  final double height;
  final double width;
  final Widget child;
  const CustomVisualizer({
    super.key,
    required this.isCompact,
    required this.isdark,
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = !isdark ? Theme.of(context).cardColor : Colors.white10;
    return RepaintBoundary(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(isCompact ? 12 : 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(isCompact ? 16 : 20),
          border: Border.all(color: const Color.fromARGB(255, 75, 65, 65)),
        ),
        child: child,
      ),
    );
  }
}
