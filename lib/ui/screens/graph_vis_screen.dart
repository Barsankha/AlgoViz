import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/engine/controller/graph_controller.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/algorithms/searching/floyd_walshall.dart';
import 'package:algov/data_structure/graph/algorithms/pages/graph_build_control.dart';
import 'package:algov/data_structure/graph/algorithms/pages/graph_visualizer.dart';
import 'package:algov/data_structure/graph/models/graph_algo_model.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/all_constant_grid.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/build_legend.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/visulazion_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphVisScreen extends StatefulWidget {
  final GraphAlgorithm algorithm;
  final GraphModel graph;
  final String description;
  final String startNode;
  final List<String> complexity;
  final List<String> pros;
  final List<String> cons;
  final List<String> useCases;
  final String notes;
  final String title;
  final String id;
  final List<String> psuedocode;

  const GraphVisScreen({
    super.key,
    required this.algorithm,
    required this.description,
    required this.complexity,
    required this.pros,
    required this.cons,
    required this.useCases,
    required this.notes,
    required this.graph,
    required this.startNode,
    required this.title,
    required this.id,
    required this.psuedocode, //
  });

  @override
  State<GraphVisScreen> createState() => _GraphVisScreenState();
}

class _GraphVisScreenState extends State<GraphVisScreen> {
  late final GraphController controller;
  late final bool isMatrix;
  @override
  void initState() {
    super.initState();

    isMatrix = widget.algorithm is FloydWarshallAlgorithm;

    controller = GraphController(
      algoSteps: GraphAlgoSteps(),
      algorithms: widget.algorithm,
      graph: widget.graph,
    );

    // Initialize base graph/tree visuals (grey state)
    controller.initWithGraph(widget.graph);

    // 🔑 Load steps EXACTLY ONCE
    final graphAlgo = widget.algorithm;

    final steps = graphAlgo.generate(widget.graph, widget.startNode);
    controller.loadSteps(steps);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    final size = MediaQuery.sizeOf(context);
    final isCompact = size.shortestSide < 600;
    //
    return Material(
      color: isdark ? Colors.black : Colors.white,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// 🔹 App bar WITHOUT Scaffold
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
                delegate: SliverChildListDelegate([
                  /// 🔹 Graph / Matrix (heavy → isolate repaint)
                  RepaintBoundary(
                    child:
                        isMatrix
                            ? DistanceMatrixWidget(
                              controller: controller,
                              isDark: isdark,
                            )
                            : CustomVisualizer(
                              isCompact: isCompact,
                              isdark: isdark,
                              height: size.height * 0.3,
                              width: size.width,
                              child: GraphVisulazionGrid(
                                isCompact: isCompact,
                                controller: controller,
                                isDark: isdark,
                              ),
                            ),
                  ),

                  const SizedBox(height: 16),

                  BuildLegend(
                    isCompact: isCompact,
                    controller: controller,
                    isdark: isdark,
                  ),

                  const SizedBox(height: 20),

                  GraphBuildControl(
                    isCompact: isCompact,
                    controller: controller,
                    algorithm: widget.algorithm,
                    graphModel: widget.graph,
                    type: (widget.algorithm).type,
                    startNode: widget.startNode,
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
                    isSearch: false,
                    title: widget.title,
                    isCompact: isCompact,
                    controller: controller,
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

abstract class DistanceAlgorithm {
  /// Node -> Node -> distance
  static const distKey = 'dist';

  /// Node -> predecessor
  static const prevKey = 'prev';
}

///
class DistanceMatrixWidget extends StatelessWidget {
  final GraphController controller;
  final bool isDark;

  const DistanceMatrixWidget({
    super.key,
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isDark ? Colors.white : Colors.black;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final step = controller.currentStep;
        Color cellColor(String r, String c) {
          if (r == step.i && c == step.j) {
            return Colors.orangeAccent; // relaxing cell
          }
          if (r == step.k || c == step.k) {
            return Colors.cyan; // intermediate
          }
          return Colors.transparent;
        }

        final matrix = step.distanceMatrix;
        if (matrix == null || matrix.isEmpty) {
          return const Center(child: Text('No matrix'));
        }
        final ids = matrix.keys.toList();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder(
              verticalInside: BorderSide(width: 1, color: Colors.grey),
              horizontalInside: BorderSide(width: 1, color: Colors.grey),
            ),
            columns: [
              DataColumn(
                label: Text('From \\ To', style: TextStyle(color: color)),
              ),
              ...ids.map(
                (id) =>
                    DataColumn(label: Text(id, style: TextStyle(color: color))),
              ),
            ],
            rows:
                ids.map((from) {
                  final row = matrix[from]!;
                  return DataRow(
                    cells: [
                      DataCell(Text(from, style: TextStyle(color: color))),
                      ...ids.map((to) {
                        final d = row[to];
                        final text =
                            d == null || d == double.infinity
                                ? '∞'
                                : d.toStringAsFixed(1);
                        //  print(text);
                        return DataCell(
                          Container(
                            decoration: BoxDecoration(
                              color: cellColor(from, to),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              softWrap: true,
                              text,
                              style: TextStyle(
                                color: color,
                                fontWeight:
                                    (from == step.i && to == step.j)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
