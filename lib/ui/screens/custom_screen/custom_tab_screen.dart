import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:algov/ui/widgets/app_widgets/cyan_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CyanSystemTabs extends StatefulWidget {
  final Widget pageOne;
  final Widget pageTwo;
  final String titleText;
  final String tab1;
  final String tab2;

  const CyanSystemTabs({
    super.key,
    required this.pageOne,
    required this.pageTwo,
    required this.titleText,
    required this.tab1,
    required this.tab2,
  });

  @override
  State<CyanSystemTabs> createState() => _CyanSystemTabsState();
}

class _CyanSystemTabsState extends State<CyanSystemTabs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    final Color color = isdark ? Colors.black : Colors.white;
    return Material(
      color: color,
      child: Column(
        children: [
          /// 🔹 Title + Tabs (AppBar replacement)
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const SizedBox(height: 6),
                CyanHeader(title: widget.titleText),
                const SizedBox(height: 6),
                CyberTabBar(
                  tabController: _tabController,
                  tab1: widget.tab1,
                  tab2: widget.tab2,
                ),
              ],
            ),
          ),

          /// 🔹 Pages
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                TabContent(color: color, child: widget.pageOne),
                TabContent(color: color, child: widget.pageTwo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final Widget child;
  final Color color;
  const TabContent({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color, // Colors.black,
      child: SafeArea(
        top: false, // AppBar already handles top
        child: child,
      ),
    );
  }
}

class CyberTabBar extends StatelessWidget {
  final TabController tabController;
  final String tab1;
  final String tab2;
  const CyberTabBar({
    super.key,
    required this.tabController,
    required this.tab1,
    required this.tab2,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    final Color color = isdark ? Colors.cyan : Colors.teal;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isdark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        ),
        child: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 0, // We use custom indicator
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withValues(alpha: 0.15),
            border: Border.all(color: color, width: 2),
            boxShadow: [AppStyles.shadow(0.3)],
          ),
          labelColor: color,
          unselectedLabelColor: !isdark ? Colors.black : Colors.white,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 1.8,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
          dividerColor: Colors.transparent,
          tabs: [Tab(text: tab1.toUpperCase()), Tab(text: tab2.toUpperCase())],
        ),
      ),
    );
  }
}
