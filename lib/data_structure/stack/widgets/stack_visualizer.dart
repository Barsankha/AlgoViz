import 'package:algov/data_structure/stack/widgets/item_box.dart';
import 'package:flutter/material.dart';

class StackVisualizer extends StatelessWidget {
  final List<int> items;
  final bool isdark;
  const StackVisualizer({super.key, required this.items, required this.isdark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Top',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isdark ? Colors.white : Colors.black,
          ),
        ),
        Expanded(
          child:
              items.isEmpty
                  ? const Center(
                    child: Text(
                      'Empty Stack',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  )
                  : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      // Reverse index so newest item (last in list) appears at top
                      final itemIndex = items.length - 1 - index;
                      return ItemBox(value: items[itemIndex], isdark: isdark);
                    },
                  ),
        ),
        Text(
          'Bottom',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isdark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
