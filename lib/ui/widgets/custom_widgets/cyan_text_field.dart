import 'package:algov/data_structure/array/models/search_item.dart';
import 'package:flutter/material.dart';

class CyanTextField extends StatelessWidget {
  final bool isCompact;
  final double width;
  final double height;
  final dynamic cont;
  final SearchingAlgorithm algorithm;
  final String labelText;
  final bool isicon;
  final bool isdark;
  final TextEditingController tcontroller;
  const CyanTextField({
    super.key,
    required this.isCompact,
    required this.width,
    required this.height,
    required this.cont,
    required this.algorithm,
    required this.labelText,
    required this.isicon,
    required this.isdark,
    required this.tcontroller,
  });

  // late final TextEditingController tcontroller;
  @override
  Widget build(BuildContext context) {
    final Color color = isdark ? Colors.cyan : Colors.teal;
    return TextField(
      style: TextStyle(
        color: color,
        fontSize: isCompact ? 16 : 18,
        fontWeight: FontWeight.bold,
      ),
      cursorColor: color,
      controller: tcontroller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        fillColor: isdark ? Colors.black : Colors.white,
        labelText: labelText,
        hintText: labelText,
        hintStyle: TextStyle(color: color.withValues(alpha: 0.4)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isCompact ? 12 : 20,
          vertical: isCompact ? 8 : 15,
        ),
        suffixIcon:
            isicon
                ? IconButton(
                  tooltip: "Search",
                  onPressed: () async {
                    final nv = int.tryParse(tcontroller.text) ?? 4;
                    if (algorithm.requiresSorted) {
                      cont.sortA();
                    }
                    await cont.restart(algorithm, nv);
                  },
                  icon: const Icon(Icons.search),
                  color: color,
                )
                : null,
        labelStyle: TextStyle(color: color),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.5),
          borderRadius: BorderRadius.circular(isCompact ? 12 : 20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withValues(alpha: 0.8),
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(isCompact ? 8 : 12),
        ),
      ),
    );
  }
}
