import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:algov/main_screen/home_screen.dart';
import 'package:algov/main_screen/saved_screen.dart';
import 'package:algov/main_screen/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
class MyHomeScreen extends StatelessWidget {
  final PageController controller;
  final ValueNotifier<int> pageNotifier;

  const MyHomeScreen({
    super.key,
    required this.pageNotifier,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      physics: const PageScrollPhysics(),
      onPageChanged: (index) {
        pageNotifier.value = index;
      },
      children: const [HomeScreen(), SavedScreen(), SettingsView()],
    );
  }
}

final List<Map<String, dynamic>> icons = [
  {'label': 'Home', 'icon': Icons.home},
  {'label': 'Saved', 'icon': Icons.bookmark_border},
  {'label': 'Settings', 'icon': Icons.settings},
];

class CustomBottomNavBar extends StatelessWidget {
  final PageController controller;
  final ValueNotifier<int> pageNotifier;
  const CustomBottomNavBar({
    super.key,
    required this.controller,
    required this.pageNotifier,
  });
  //

  //
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemwidth = size.width / icons.length;
    final theme = context.select((AppBloc b) => b.state.theme);
    final bool isdark = theme == AppTheme.dark;
    return Container(
      height: size.height * 0.1,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.transparent,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: pageNotifier,
              builder: (_, scp, _) {
                return Positioned(
                  top: 0,
                  left: (itemwidth * scp) + (itemwidth / 2) - 4,
                  child: Dot(isdark: isdark),
                );
              },
            ),
            Row(
              children: List.generate(icons.length, (index) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ValueListenableBuilder<int>(
                    valueListenable: pageNotifier,
                    builder: (_, page, __) {
                      final isActive = page == index;
                      return GestureDetector(
                        onTap: () {
                          if (controller.hasClients) {
                            controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCubic,
                            );
                          }
                        },
                        child: NavIcon(
                          icon: icons[index]['icon'],
                          label: icons[index]['label'],
                          isActive: isActive,
                          isDark: isdark,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isdark;
  const Dot({super.key, required this.isdark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        color: isdark ? AppColors.darkActive : AppColors.lightActive,
        shape: BoxShape.circle,
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isDark;

  const NavIcon({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final finalcolor = isActive ? Color(0xFF00D1FF) : Colors.grey;
    final color = isDark ? finalcolor : AppColors.lightActive;
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Icon(icon, color: color),
          Text(
            label,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
