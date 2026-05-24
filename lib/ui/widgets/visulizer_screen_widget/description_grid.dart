import 'package:flutter/material.dart';

class DescriptionGrid extends StatelessWidget {
  final String title;
  final bool isNotes;
  final bool isCompact;
  final String description;
  final List<String> complexity;
  final List<String> pros;
  final List<String> cons;
  final List<String> useCases;
  final String notes;
  final bool isDark;
  const DescriptionGrid({
    super.key,
    required this.isCompact,
    required this.description,
    required this.complexity,
    required this.pros,
    required this.cons,
    required this.useCases,
    required this.notes,
    required this.isDark,
    required this.title,
    required this.isNotes,
  });

  @override
  Widget build(BuildContext context) {
    Color color = isDark ? Colors.white : Colors.black;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Algorithm Description",
          style: TextStyle(
            fontSize: isCompact ? 16 : 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isCompact ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            if (isNotes) _specialnotes(color),
          ],
        ),

        const SizedBox(height: 6),
        if (!isNotes) _specialnotes(color),
        const SizedBox(height: 12),
        Text(description, style: TextStyle(color: color, height: 1.5)),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _infoBlock(
                "Time Complexity",
                "Best: ${complexity[0]}\nAverage: ${complexity[1]}\nWorst: ${complexity[2]}",
                isCompact,
                color,
              ),
            ),
            if (complexity.length == 4)
              Expanded(
                child: _infoBlock(
                  "Space Complexity",
                  complexity[3],
                  isCompact,
                  color,
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _bulletInfoBlock("Pros", pros, isCompact, color)),
            Expanded(child: _bulletInfoBlock("Cons", cons, isCompact, color)),
          ],
        ),
        const SizedBox(height: 20),
        _bulletInfoBlock("Real-World Use Cases", useCases, isCompact, color),
      ],
    );
  }

  Widget _specialnotes(Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 6 : 8,
        vertical: isCompact ? 1 : 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.1,
        ), //Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        notes,
        style: TextStyle(fontSize: isCompact ? 10 : 12, color: color),
      ),
    );
  }

  Widget _infoBlock(String title, String content, bool isCompact, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color, // Colors.white38,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: isCompact ? 13 : 14,
            height: 1.4,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _bulletInfoBlock(
    String title,
    List<String> items,
    bool isCompact,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color, // Colors.white38,
            fontSize: isCompact ? 11 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: TextStyle(fontSize: 15, height: 1.2, color: color),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: isCompact ? 14 : 15,
                      height: 1.2,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
