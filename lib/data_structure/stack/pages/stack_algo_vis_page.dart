import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/data_structure/stack/bloc/stack_bloc.dart';
import 'package:algov/data_structure/stack/widgets/control_panel.dart';
import 'package:algov/data_structure/stack/widgets/stack_visualizer.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/all_constant_grid.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/visulazion_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StackAlgoVisPage extends StatefulWidget {
  const StackAlgoVisPage({super.key});

  @override
  State<StackAlgoVisPage> createState() => _StackAlgoVisPageState();
}

class _StackAlgoVisPageState extends State<StackAlgoVisPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isCompact = size.shortestSide < 600;
    final bool isdark = context.read<AppBloc>().state.theme == AppTheme.dark;
    final stackRepo = AlgorithmRepository.stackAlgo[0];
    return Material(
      color: isdark ? Colors.black : Colors.white,
      child: SafeArea(
        bottom: false,
        child: BlocProvider(
          create: (context) => DataStructureBloc(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: CustomAppBar(
                  id: stackRepo.id,
                  titleText: 'Stack',
                  icon: const Icon(Icons.arrow_back),
                  isp: true,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(isCompact ? 12 : 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    BlocBuilder<DataStructureBloc, DataStructureState>(
                      builder: (context, state) {
                        return CustomVisualizer(
                          isCompact: isCompact,
                          isdark: isdark,
                          height: size.height * 0.3,
                          width: size.width,
                          child: StackVisualizer(
                            items: state.items,
                            isdark: isdark,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ControlsPanel(
                      isCompact: isCompact,
                      isdark: isdark,
                      type: StructureType.stack,
                    ),
                    const SizedBox(height: 20),
                    AllConstantDescriprionGrid(
                      description: stackRepo.description,
                      complexity: stackRepo.complexity,
                      pros: stackRepo.pros,
                      cons: stackRepo.cons,
                      useCases: stackRepo.usecases,
                      notes: stackRepo.notes,
                      isSearch: false,
                      title: stackRepo.title,
                      isCompact: isCompact,
                      isDark: isdark,
                      psuedocode: stackRepo.psuedocode,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
