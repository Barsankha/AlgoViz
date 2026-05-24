import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/app/routes.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/constants/constant.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:algov/ui/screens/custom_screen/categories_grid_screen.dart';
import 'package:algov/ui/screens/custom_screen/search_screen.dart';
import 'package:algov/ui/widgets/app_widgets/categories_list.dart';
import 'package:algov/ui/widgets/app_widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: kToolbarHeight + 60)),
        const SliverToBoxAdapter(
          child: RepaintBoundary(
            child: Padding(padding: EdgeInsets.all(10), child: _TopContent()),
          ),
        ),

        // Rest of the page (grid)
        const SliverToBoxAdapter(child: SliverAlgorithmGrid()),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

class _TopContent extends StatelessWidget {
  const _TopContent();

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroSection(),
          SizedBox(height: 25),
          _SearchBarSection(),
          SizedBox(height: 35),
          SectionHeader(title: 'Categories'),
          SizedBox(height: 15),
          CategoryList(),
          SizedBox(height: 35),
          SectionHeader(title: 'Popular'),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _SearchBarSection extends StatelessWidget {
  const _SearchBarSection();

  @override
  Widget build(BuildContext context) {
    return CustomSearchBar(
      hintText: 'Search bubble sort, dfs...',
      ontap: () {
        RouteAnim.push(context, const SearchScreen(), AnimType.slide);
      },
    );
  }
}

// // ──────────────────────────────────────────────

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        context.select((AppBloc bloc) => bloc.state.theme) == AppTheme.dark;

    return RepaintBoundary(
      // ← isolate gradient & rich text
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              children: [
                TextSpan(
                  text: 'Master Algorithms\n',
                  style: TextStyle(
                    color: isDark ? AppColors.darkHero : AppColors.lightActive,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                WidgetSpan(
                  child: BlocProvider(
                    create:
                        (_) => AppBloc()..add(StartGradientText('Visually')),
                    child: GradientText(
                      'Visually',
                      gradientColors:
                          isDark
                              ? AppColors.darkGradient
                              : AppColors.lightGradient,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Interactive visualizations for sorting,\npathfinding, trees, and more.',
            style: TextStyle(
              color: isDark ? AppColors.darkHeroit : AppColors.lightblack,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;

  const SectionHeader({super.key, required this.title, this.actionText});

  @override
  Widget build(BuildContext context) {
    final isDark =
        context.select((AppBloc b) => b.state.theme) == AppTheme.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppStyles.textStyle(
          title,
          20,
          isDark ? AppColors.darkHero : AppColors.lightActive,
          FontWeight.bold,
        ),
        if (actionText != null)
          GestureDetector(
            onTap:
                () => RouteAnim.push(
                  context,
                  const CustomGridPage(),
                  AnimType.fade,
                ),
            child: Text(
              actionText!,
              style: TextStyle(
                color:
                    isDark ? AppColors.darkDrawerItem : AppColors.lightActive,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }
}

class SliverAlgorithmGrid extends StatelessWidget {
  const SliverAlgorithmGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Responsive rows
    final int rows =
        width >= 1200
            ? 4 + 2
            : width >= 800
            ? 4
            : 2;
    final isDark =
        context.select((AppBloc b) => b.state.theme) == AppTheme.dark;

    return SizedBox(
      height: rows * 140.0 + ((rows) * 16),
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = newitems[index];
                return RepaintBoundary(
                  child: GestureDetector(
                    onTap:
                        () => RouteAnim.push(
                          context,
                          item.path,
                          AnimType.circular,
                        ), //
                    child: Container(
                      decoration:
                          isDark
                              ? AppColors.darkpopulargridDecoration
                              : AppColors.lightpopularGridDecoration,
                      padding: const EdgeInsets.all(10),
                      child: _GridItemContent(item: item, isDark: isDark),
                    ),
                  ),
                );
              }, childCount: newitems.length),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridItemContent extends StatelessWidget {
  final AlgoItem item;
  final bool isDark;

  const _GridItemContent({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final Color color = isDark ? AppColors.darkDrawerItem : Colors.tealAccent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(item.icon, size: 80, color: color),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.textStyle(
                    item.name,
                    14,
                    isDark ? Colors.white : Colors.teal,
                    FontWeight.bold,
                  ),
                  const SizedBox(height: 2),
                  AppStyles.textStyle(
                    item.meta,
                    10,
                    isDark ? Colors.grey : Colors.teal,
                    FontWeight.normal,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: const Icon(
                CupertinoIcons.play,
                size: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
