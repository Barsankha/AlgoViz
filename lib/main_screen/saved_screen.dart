import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/routes.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/constants/constant.dart';
import 'package:algov/data_structure/algorithm_utils/algo_info.dart';
import 'package:algov/data_structure/algorithm_utils/algo_repository.dart';
import 'package:algov/data_structure/algorithm_utils/algorithm_factory.dart';
import 'package:algov/ui/widgets/app_widgets/custom_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, n) => p.bookmarkIds != n.bookmarkIds,
        builder: (context, state) {
          if (state.bookmarkIds.isEmpty) {
            return const _EmptySaved();
          }
          //

          final List<AlgorithmInfo> savedList =
              state.bookmarkIds
                  .toList()
                  .map((id) => AlgorithmRepository.findById(id))
                  .whereType<AlgorithmInfo>()
                  .toList();
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: savedList.length,
            itemBuilder: (context, index) {
              final page = savedList[index];
              return AlgorithmCard(
                onTap: () {
                  openSaved(context, page.id);
                },
                title: page.title,
                complexity: page.complexity[2],
                description: page.description,
                icon: page.icon,
                complexityColor: page.complexityColor,
                isbookmarked: true,
                id: page.id,
              );
            },
          );
        },
      ),
    );
  } //
}

class _EmptySaved extends StatelessWidget {
  const _EmptySaved();

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = context.watch<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 96),
          Image.asset(isdark ? computerills : boyills, fit: BoxFit.cover),
          const SizedBox(height: 12),
          const Icon(Icons.bookmark_border, size: 60, color: Colors.grey),
          const SizedBox(height: 12),
          const Text(
            'No saved algorithms',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

void openSaved(BuildContext context, String page) {
  final algo = AlgorithmRepository.findById(page);
  final al = AlgorithmFactory.search(algo!.algoCategory, algo.type);
  if (algo.algoCategory == AlgoCategory.graph) {
    RouteAnim.push(context, RouteAnim.buildGraph(al, algo), AnimType.fade);
  } else if (algo.algoCategory == AlgoCategory.tree) {
    RouteAnim.push(context, RouteAnim.buildTree(al, algo), AnimType.fade);
  } else if (algo.algoCategory == AlgoCategory.searching ||
      algo.algoCategory == AlgoCategory.sorting) {
    RouteAnim.push(context, RouteAnim.buildScreen(al, algo), AnimType.fade);
  } else {
    RouteAnim.push(context, al, AnimType.slide);
  }
}
