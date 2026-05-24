import 'package:algov/data_structure/hash/bloc/hash_bloc.dart';
import 'package:algov/data_structure/hash/widgets/bucket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HashVisualizer extends StatelessWidget {
  final bool isdark;
  const HashVisualizer({super.key, required this.isdark});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HashBloc, HashState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: List.generate(
              HashState.bucketCount,
              (i) => BucketCard(
                index: i,
                chain: state.buckets[i],
                type: state.type,
                isdark: isdark,
              ),
            ),
          ),
        );
      },
    );
  }
}
