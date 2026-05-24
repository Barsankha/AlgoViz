import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/algorithm_utils/algo_info.dart';
import 'package:algov/ui/widgets/app_widgets/custom_tile.dart';
import 'package:algov/ui/widgets/app_widgets/cyan_header.dart';
import 'package:algov/ui/widgets/app_widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlgorithmsScreen extends StatefulWidget {
  final String titleText;
  final List<AlgorithmInfo> alorithm;
  final void Function(AlgorithmInfo algo) function;

  const AlgorithmsScreen({
    super.key,
    required this.titleText,
    required this.alorithm,
    required this.function,
  });

  @override
  State<AlgorithmsScreen> createState() => _AlgorithmsScreenState();
}

class _AlgorithmsScreenState extends State<AlgorithmsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppBloc>().state.theme;
    final isDark = theme == AppTheme.dark;
    return Material(
      color: isDark ? Colors.black : Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            /// 🔹 Header with back arrow
            CyanHeader(title: widget.titleText),

            const SizedBox(height: 12),

            /// 🔹 Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(
                hintText: 'Search algorithms...',
                controller: searchController,
                onSearchchanged: (value) async {
                  context.read<AppBloc>().add(SearchQueryChanged(value));
                },
              ),
            ),

            const SizedBox(height: 6),

            /// 🔹 List
            Expanded(
              child: BlocBuilder<AppBloc, AppState>(
                buildWhen:
                    (previous, current) =>
                        previous.searchquery != current.searchquery,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AlgoScreen(
                      alorithm: widget.alorithm,
                      query: state.searchquery,
                      function: widget.function,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlgoScreen extends StatelessWidget {
  final List<AlgorithmInfo> alorithm;
  final String query;
  final void Function(AlgorithmInfo algo) function;

  const AlgoScreen({
    super.key,
    required this.alorithm,
    required this.query,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    final filtered =
        query.isEmpty
            ? alorithm
            : alorithm
                .where(
                  (e) => e.title.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();

    return ListView.builder(
      itemExtent: 100,
      physics: const BouncingScrollPhysics(),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return AlgorithmCard(
          key: ValueKey(item.title),
          title: item.title,
          complexity: item.complexity[2].toString(),
          description: item.description,
          icon: item.icon,
          complexityColor: item.complexityColor,
          onTap: () => function(item),
          isbookmarked: false,
          id: item.id,
        );
      },
    );
  }
}
