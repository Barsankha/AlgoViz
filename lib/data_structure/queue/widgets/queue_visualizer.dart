import 'package:algov/data_structure/stack/widgets/item_box.dart';
import 'package:flutter/material.dart';

class QueueVisualizer extends StatelessWidget {
  final List<int> items;
  final bool isdark;
  const QueueVisualizer({super.key, required this.items, required this.isdark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Front',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isdark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                'Rear',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isdark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child:
              items.isEmpty
                  ? const Center(
                    child: Text(
                      'Empty Queue',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  )
                  : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder:
                        (_, index) =>
                            ItemBox(value: items[index], isdark: isdark),
                  ),
        ),
      ],
    );
  }
}
