import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/data_structure/array/models/search_item.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:flutter/material.dart';

class BuildControls extends StatelessWidget {
  final bool isCompact;
  final VisualController controller;
  final Algo algorithm;
  const BuildControls({
    super.key,
    required this.isCompact,
    required this.controller,
    required this.algorithm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IconButton(
        //   onPressed: () {
        //     if (controller is SortingController) {
        //       (controller as SortingController).previousStep();
        //     }
        //   },
        //   icon: const Icon(Icons.first_page, size: 32),
        // ),
        SizedBox(width: isCompact ? 16 : 20),
        GestureDetector(
          onTap: () async {
            if (controller is SearchAlgoController) {
              final algo = algorithm as SearchingAlgorithm;
              final cont = controller as SearchAlgoController;
              if (algo.requiresSorted) {
                await cont.sortA();
              }
            }
            if (!controller.isSorting) {
              //handleplayPress(playcontroller);
              await controller.start(algorithm);
            } else {
              //handleplayPress();
              controller.isPlaying ? controller.pause() : controller.play();
            }
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
        // IconButton(
        // onPressed: controller.nextStep,
        // controller.currentStep < controller.steps.length - 1
        //    ? controller.next
        //      : null,
        // icon: const Icon(Icons.last_page, size: 32),
        // ),
      ],
    );
  }
}
//