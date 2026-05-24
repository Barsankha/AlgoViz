import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/configuration_grid.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/description_grid.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/psuedocode_section.dart';
import 'package:flutter/material.dart';

class AllConstantDescriprionGrid extends StatelessWidget {
  final Algo? algorithm;
  final String description;
  final List<String> complexity;
  final List<String> pros;
  final List<String> cons;
  final List<String> useCases;
  final String notes;
  final bool isSearch;
  final String title;
  final bool isCompact;
  final VisualController? controller;
  final bool isDark;
  final List<String> psuedocode;
  const AllConstantDescriprionGrid({
    super.key,
    this.algorithm,
    required this.description,
    required this.complexity,
    required this.pros,
    required this.cons,
    required this.useCases,
    required this.notes,
    required this.isSearch,
    required this.title,
    required this.isCompact,
    this.controller,
    required this.isDark,
    required this.psuedocode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isConfig = (controller != null || algorithm != null);
    final bool isNotes = algorithm is SortingAlgorithm;
    return RepaintBoundary(
      child: Column(
        children: [
          isConfig
              ? ConfigarationGrid(
                isCompact: isCompact,
                algorithm: algorithm!,
                controller: controller!,
                isdark: isDark,
              )
              : SizedBox.shrink(),
          const SizedBox(height: 24),
          BuildPseudoCodeSection(
            isCompact: isCompact,
            pseudocodeLines: psuedocode,
            isdark: isDark,
          ),
          const SizedBox(height: 24),
          RepaintBoundary(
            child: DescriptionGrid(
              title: title,
              isCompact: isCompact,
              isNotes: isNotes,
              description: description,
              complexity: complexity,
              pros: pros,
              cons: cons,
              useCases: useCases,
              notes: notes,
              isDark: isDark,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
