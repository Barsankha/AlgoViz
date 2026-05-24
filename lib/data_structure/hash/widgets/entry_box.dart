import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/hash/models/items.dart';
import 'package:flutter/material.dart';

class HashEntryBox extends StatelessWidget {
  final HashItem item;
  final DsType type;

  const HashEntryBox({super.key, required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade700,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type == DsType.hashMap
                ? 'Key: ${item.hashKey}'
                : 'Element: ${item.hashKey}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (type == DsType.hashMap && item.mapValue != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Value: ${item.mapValue}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
