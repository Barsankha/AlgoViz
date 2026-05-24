import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/core/engine/controller/sorting_controller.dart';
import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/data_structure/array/widgets/visualizer.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/all_constant_grid.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/build_controls.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/build_legend.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/visulazion_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisualizerScreen<T extends Algo, C extends VisualController>
    extends StatefulWidget {
  final T algorithm;
  final String description;
  final List<String> complexity;
  final List<String> pros;
  final List<String> cons;
  final List<String> useCases;
  final String notes;
  final bool isSearch;
  final String title;
  final String id;
  final List<String> psuedocode;
  const VisualizerScreen({
    super.key,
    required this.algorithm,
    required this.description,
    required this.complexity,
    required this.pros,
    required this.cons,
    required this.useCases,
    required this.notes,
    required this.isSearch,
    required this.title,
    required this.id,
    required this.psuedocode,
  });

  @override
  State<VisualizerScreen<T, C>> createState() => _VisualizerScreenState<T, C>();
}

class _VisualizerScreenState<T extends Algo, C extends VisualController>
    extends State<VisualizerScreen<T, C>>
    with TickerProviderStateMixin {
  late final VisualController _controller;
  @override
  void initState() {
    if (widget.isSearch) {
      _controller = SearchAlgoController();
    } else {
      _controller = SortingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    final size = MediaQuery.sizeOf(context);
    final isCompact =
        size.shortestSide < 600; // Responsive: compact mode for small screens
    return Material(
      color: isdark ? Colors.black : Colors.white,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(
                id: widget.id,
                titleText: widget.algorithm.name,
                icon: const Icon(Icons.arrow_back),
                isp: true,
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.all(isCompact ? 12 : 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  RepaintBoundary(
                    child: CustomVisualizer(
                      height: size.height * 0.31,
                      width: size.width,
                      isCompact: isCompact,
                      isdark: isdark,
                      child: ArrayGrid(
                        isCompact: isCompact,
                        controller: _controller,
                        isDark: isdark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BuildLegend(
                    isCompact: isCompact,
                    controller: _controller,
                    isdark: isdark,
                  ),
                  const SizedBox(height: 20),
                  if (widget.algorithm is SortingAlgorithm)
                    BuildControls(
                      isCompact: isCompact,
                      controller: _controller,
                      algorithm: widget.algorithm,
                    ),
                  const SizedBox(height: 24),
                  AllConstantDescriprionGrid(
                    algorithm: widget.algorithm,
                    description: widget.description,
                    complexity: widget.complexity,
                    pros: widget.pros,
                    cons: widget.cons,
                    useCases: widget.useCases,
                    notes: widget.notes,
                    isSearch: widget.isSearch,
                    title: widget.title,
                    isCompact: isCompact,
                    controller: _controller,
                    isDark: isdark,
                    psuedocode: widget.psuedocode,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
