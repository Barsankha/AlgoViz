import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/data_structure/hash/bloc/hash_bloc.dart';
import 'package:algov/data_structure/hash/widgets/hash_controls.dart';
import 'package:algov/data_structure/hash/widgets/hash_vis.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/all_constant_grid.dart';
import 'package:algov/ui/widgets/visulizer_screen_widget/visulazion_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HashSetHome extends StatelessWidget {
  const HashSetHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isCompact = size.shortestSide < 600;
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    final hashRepo = AlgorithmRepository.hashAlgo[1];
    return Material(
      color: isdark ? Colors.black : Colors.white,
      child: SafeArea(
        bottom: false,
        child: BlocProvider(
          create: (_) => HashBloc(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App bar
              SliverToBoxAdapter(
                child: CustomAppBar(
                  id: hashRepo.id,
                  titleText: 'HashSet',
                  icon: const Icon(Icons.arrow_back),
                  isp: true,
                ),
              ),
              // Visualizer section with padding
              SliverPadding(
                padding: EdgeInsets.all(isCompact ? 12 : 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    CustomVisualizer(
                      isCompact: isCompact,
                      isdark: isdark,
                      height: size.height * 0.4,
                      width: size.width,
                      child: HashVisualizer(isdark: isdark),
                    ),
                    SizedBox(height: 10),
                    HashControls(
                      isCompact: isCompact,
                      isdark: isdark,
                      type: DsType.hashSet,
                    ),
                    SizedBox(height: 10),
                    AllConstantDescriprionGrid(
                      description: hashRepo.description,
                      complexity: hashRepo.complexity,
                      pros: hashRepo.pros,
                      cons: hashRepo.cons,
                      useCases: hashRepo.usecases,
                      notes: hashRepo.notes,
                      isSearch: false,
                      title: hashRepo.title,
                      isCompact: isCompact,
                      isDark: isdark,
                      psuedocode: hashRepo.psuedocode,
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
