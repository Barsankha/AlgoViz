import 'package:algov/core/engine/controller/graph_controller.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:flutter/material.dart';

class GraphBuildControl extends StatelessWidget {
  final bool isCompact;
  final GraphController controller;
  final GraphAlgorithm algorithm;
  final GraphModel graphModel;
  final String startNode;
  final GraphAlgoType type;
  const GraphBuildControl({
    super.key,
    required this.isCompact,
    required this.controller,
    required this.algorithm,
    required this.graphModel,
    required this.type,
    required this.startNode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: controller.previous,
          icon: const Icon(Icons.first_page, size: 32),
        ),
        SizedBox(width: isCompact ? 16 : 20),
        GestureDetector(
          onTap: () async {
            controller.isPlaying
                ? controller.pause()
                : controller.startAlgorithm(
                  type,
                  graph: graphModel,
                  startNodeId: startNode,
                );
          },
          child: CircleAvatar(
            radius: isCompact ? 32 : 40,
            backgroundColor: Colors.cyan.withValues(alpha: 0.1),
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, __) {
                return Icon(
                  controller.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                  size: isCompact ? 35 : 45,
                  color: Colors.cyanAccent,
                );
              },
            ),
          ),
        ),
        SizedBox(width: isCompact ? 20 : 16),
        IconButton(
          //
          onPressed: controller.next,
          icon: const Icon(Icons.last_page, size: 32),
        ),
      ],
    );
  }
}
