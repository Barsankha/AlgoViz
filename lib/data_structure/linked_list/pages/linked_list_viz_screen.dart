import 'dart:math' as math;
import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/overlay_service.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/data_structure/graph/enums/node_state.dart';
import 'package:algov/data_structure/linked_list/models/linked_list_model.dart';
import 'package:algov/data_structure/linked_list/widgts/container_widgets.dart';
import 'package:algov/data_structure/linked_list/widgts/linked_list_vis.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/all_constant_grid.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/visulazion_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkedListVisualizer extends StatefulWidget {
  const LinkedListVisualizer({super.key});

  @override
  State<LinkedListVisualizer> createState() => _LinkedListVisualizerState();
}

//
class _LinkedListVisualizerState extends State<LinkedListVisualizer> {
  final VisualLinkedList vll = VisualLinkedList();
  double totalWidth = 50.0;

  final TextEditingController valueController = TextEditingController();
  final TextEditingController positionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    vll.insertAtEnd(10);
    vll.insertAtEnd(20);
    vll.insertAtEnd(30);
    vll.insertAtEnd(40);
    _computeLayout();
  }

  void _computeLayout() {
    const double centerY = 80.0;
    const double startX = 10.0;

    // Responsive + nice looking
    final double baseSpacing = 60.0;
    final double minSpacing = 160.0;
    // final double maxSpacing = 280.0;

    // Optional: make it a bit tighter when many nodes
    double spacing = baseSpacing;
    if (vll.length > 8) {
      spacing = math.max(minSpacing, baseSpacing - (vll.length - 8) * 8);
    }

    double x = startX;

    // Head
    x += startX * 1;
    vll.nodes['head'] = vll.nodes['head']!.copyWith(
      position: Offset(x, centerY),
    );

    // Data nodes
    for (final id in vll.dataNodeIds) {
      x += spacing;
      vll.nodes[id] = vll.nodes[id]!.copyWith(position: Offset(x, centerY));
    }

    // Null
    x += spacing * 1;
    vll.nodes['null'] = vll.nodes['null']!.copyWith(
      position: Offset(x, centerY),
    );

    totalWidth = x + 400;
  }

  void _refresh() {
    _computeLayout();
    setState(() {});
  }

  Future<void> _traverse() async {
    // Reset states
    for (final id in vll.dataNodeIds) {
      vll.nodes[id] = vll.nodes[id]!.copyWith(
        state: NodeState.unvisited,
        highlighted: false,
      );
    }
    _refresh();

    for (final id in vll.dataNodeIds) {
      vll.nodes[id] = vll.nodes[id]!.copyWith(state: NodeState.current);
      _refresh();
      await Future.delayed(const Duration(milliseconds: 800));
      vll.nodes[id] = vll.nodes[id]!.copyWith(state: NodeState.visited);
      _refresh();
    }
  }

  void _search(String text) {
    final int? value = int.tryParse(text);
    if (value == null) {
      return _showError(context, 'Enter a valid integer', false);
    }

    // Reset highlights
    for (final id in vll.dataNodeIds) {
      vll.nodes[id] = vll.nodes[id]!.copyWith(highlighted: false);
    }

    bool found = false;
    for (final id in vll.dataNodeIds) {
      if (vll.nodes[id]!.meta['data'] == value) {
        vll.nodes[id] = vll.nodes[id]!.copyWith(highlighted: true);
        found = true;
      }
    }

    CoolToast.show(
      context,
      found ? 'Found $value' : '$value not found',
      isError: found,
    );
    _refresh();
  }

  void _showError(BuildContext context, String message, bool isError) {
    CoolToast.show(context, message, isError: !isError);
  } //

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isCompact = size.shortestSide < 600;
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    final linkeListRepo = AlgorithmRepository.linkedListAlgo[0];
    return Material(
      color: isdark ? Colors.black : Colors.white,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(
                id: linkeListRepo.id,
                titleText: 'Linked List',
                icon: const Icon(Icons.arrow_back),
                isp: true,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(isCompact ? 12 : 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  CustomVisualizer(
                    isCompact: isCompact,
                    isdark: isdark,
                    height: size.height * 0.2,
                    width: size.width,
                    child: LinkedListGraphVisualization(
                      vll: vll,
                      totalWidth: totalWidth,
                      height: size.height * 0.2,
                      isCompact: isCompact,
                      isDark: isdark,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ContainerWidget(
                    valueController: valueController,
                    positionController: positionController,
                    vll: vll,
                    refresh: _refresh,
                    showError: _showError,
                    traverse: _traverse,
                    search: (val) {
                      _search(val);
                    },
                    isdark: isdark,
                    isCompact: isCompact,
                  ),
                  const SizedBox(height: 10),
                  AllConstantDescriprionGrid(
                    description: linkeListRepo.description,
                    complexity: linkeListRepo.complexity,
                    pros: linkeListRepo.pros,
                    cons: linkeListRepo.cons,
                    useCases: linkeListRepo.usecases,
                    notes: linkeListRepo.notes,
                    isSearch: false,
                    title: linkeListRepo.title,
                    isCompact: isCompact,

                    isDark: isdark,
                    psuedocode: linkeListRepo.psuedocode,
                  ),
                  const SizedBox(height: 20),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
