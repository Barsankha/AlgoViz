import 'package:flutter/material.dart';

class ItemBox extends StatelessWidget {
  final int value;
  final bool isdark;
  const ItemBox({super.key, required this.value, required this.isdark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: isdark ? Colors.cyan : Colors.tealAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '$value',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
