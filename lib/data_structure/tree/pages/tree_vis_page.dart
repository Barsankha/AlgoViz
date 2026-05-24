import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/engine/controller/tree_controller.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/graph/algorithms/pages/graph_visualizer.dart';
import 'package:algov/data_structure/graph/steps/graph_steps.dart';
import 'package:algov/data_structure/tree/models/tree_algo.dart';
import 'package:algov/data_structure/tree/models/tree_model.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/all_constant_grid.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/build_legend.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/visulazion_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreeVisPage extends StatefulWidget {
  final TreeAlgorithm algorithm;
  final TreeModel graph;
  final String description;
  final String startNode;
  final List<String> complexity;
  final List<String> pros;
  final List<String> cons;
  final List<String> useCases;
  final String notes;
  final String title;
  final String id;
  final List<String> psuwdocode;

  const TreeVisPage({
    super.key,
    required this.algorithm,
    required this.graph,
    required this.description,
    required this.startNode,
    required this.complexity,
    required this.pros,
    required this.cons,
    required this.useCases,
    required this.notes,
    required this.title,
    required this.id,
    required this.psuwdocode,
  });

  @override
  State<TreeVisPage> createState() => _TreeVisPageState();
}

class _TreeVisPageState extends State<TreeVisPage> {
  late TreeController controller;
  @override
  void initState() {
    super.initState();
    controller = TreeController(
      algoSteps: GraphAlgoSteps(),
      algorithms: widget.algorithm,
      graph: widget.graph,
    );
    controller.initWithGraph(widget.graph);

    final graphAlgo = widget.algorithm;

    final steps = graphAlgo.generate(widget.graph);
    controller.loadSteps(steps);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isCompact = size.shortestSide < 600;
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
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
                titleText: widget.title,
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
                    height: size.height * 0.3,
                    width: size.width,
                    child: GraphVisulazionGrid(
                      isCompact: isCompact,
                      controller: controller,
                      isDark: isdark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ResultArray(
                    isCompact: isCompact,
                    height: size.height * 0.07,
                    width: size.width * 0.5,
                    controller: controller,
                    isdark: isdark,
                  ),
                  const SizedBox(height: 16),

                  BuildLegend(
                    isCompact: isCompact,
                    controller: controller,
                    isdark: isdark,
                  ),

                  const SizedBox(height: 20),

                  TreeBuildControl(
                    isCompact: isCompact,
                    controller: controller,
                    algorithm: widget.algorithm,
                    graphModel: widget.graph,
                    type: widget.algorithm.type,
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
                    psuedocode: widget.psuwdocode,
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

class ResultArray extends StatelessWidget {
  final bool isCompact;
  final double height;
  final double width;
  final bool isdark;
  final TreeController controller;
  const ResultArray({
    super.key,
    required this.isCompact,
    required this.height,
    required this.width,
    required this.controller,
    required this.isdark,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = !isdark ? Theme.of(context).cardColor : Colors.white10;
    final Color stepcolor = isdark ? Colors.cyanAccent : Colors.teal;
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(isCompact ? 12 : 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color.fromARGB(255, 75, 65, 65)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final step = controller.currentStep.result.toString().replaceAll(
              "[]",
              "",
            );
            return Text(
              step,
              style: TextStyle(
                color: stepcolor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TreeBuildControl extends StatelessWidget {
  final bool isCompact;
  final TreeController controller;
  final TreeAlgorithm algorithm;
  final TreeModel graphModel;
  final String startNode;
  final TreeAlgoType type;
  const TreeBuildControl({
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
                : controller.startAlgorithm(type, graph: graphModel);
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
          onPressed: controller.next,
          icon: const Icon(Icons.last_page, size: 32),
        ),
      ],
    );
  }
}
