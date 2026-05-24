import 'package:flutter/material.dart';

class ConfigItem extends StatelessWidget {
  final double width;
  final String label;
  final Widget child;
  final bool isdark;
  const ConfigItem({
    super.key,
    required this.width,
    required this.label,
    required this.child,
    required this.isdark,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isdark ? Colors.white38 : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
