import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/about_page.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/card_title.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/visuals._page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  //
  static const bg = Color(0xFF0B0F14);
  static const card = Color(0xFF121821);
  static const accent = Colors.cyanAccent;
  @override
  Widget build(BuildContext context) {
    final bool isdark = context.select(
      (AppBloc b) => b.state.theme == AppTheme.dark,
    );
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverToBoxAdapter(child: _Header(isdark)),
          ),

          // Tabs
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(child: _Tabs(isdark)),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverToBoxAdapter(
              child: RepaintBoundary(
                child: BlocSelector<AppBloc, AppState, SettingMode>(
                  selector: (s) => s.mode,
                  builder: (context, mode) {
                    switch (mode) {
                      case SettingMode.visuals:
                        return VisualsPage();
                      default:
                        return MyWidget();
                    }
                  },
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isDark;
  const _Header(this.isDark);

  @override
  Widget build(BuildContext context) {
    final String title = "Setting";
    return BlocProvider(
      create: (_) => AppBloc()..add(StartGradientText(title)),
      child: GradientText(
        title,
        gradientColors:
            isDark ? AppColors.darkGradient : AppColors.lightGradient,
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  final bool isdark;
  const _Tabs(this.isdark);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isdark ? SettingsView.card : Colors.blueGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return Row(
            children: [
              _Tab(
                'Visuals',
                state.mode == SettingMode.visuals,
                SettingMode.visuals,
              ),
              _Tab('About', state.mode == SettingMode.about, SettingMode.about),
            ],
          );
        },
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool active;
  final SettingMode mode;

  const _Tab(this.label, this.active, this.mode);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainerWidget(
      active: active,
      ontap: () {
        context.read<AppBloc>().add(SettingChanged(mode));
      },
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: active ? Colors.white : Colors.white54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
