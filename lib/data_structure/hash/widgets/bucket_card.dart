import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/hash/models/items.dart';
import 'package:algov/data_structure/hash/widgets/entry_box.dart';
import 'package:flutter/material.dart';

class BucketCard extends StatelessWidget {
  final int index;
  final List<HashItem> chain;
  final DsType type;
  final bool isdark;

  const BucketCard({
    super.key,
    required this.index,
    required this.chain,
    required this.type,
    required this.isdark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isdark ? Colors.cyan : Colors.teal,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(minWidth: 180),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bucket $index',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1),
            const SizedBox(height: 12),
            if (chain.isEmpty)
              const Text(
                'Empty',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              )
            else
              ...chain.map((item) => HashEntryBox(item: item, type: type)),
          ],
        ),
      ),
    );
  }
}
