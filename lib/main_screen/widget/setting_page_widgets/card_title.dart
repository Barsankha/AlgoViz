import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/main_screen/setting_page.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/motion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final bool isdark;
  const CardWidget({super.key, required this.child, required this.isdark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isdark ? SettingsView.card : Colors.white70,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}

Widget title(String text, Color color) => Text(
  text,
  style: TextStyle(
    color: color, //Colors.white54,
    fontSize: 12,
    letterSpacing: 1.1,
  ),
);

//
class AnimatedContainerWidget extends StatelessWidget {
  final Widget child;
  final bool active;
  final void Function() ontap;
  const AnimatedContainerWidget({
    super.key,
    required this.child,
    required this.active,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isdark = context.read<AppBloc>().state.theme == AppTheme.dark;
    final bool reducedMotion = context.read<AppBloc>().state.reduceMotion;
    final motion = MotionConfig(reducedMotion);
    final Color color = active ? const Color(0xFF1F2A3A) : Colors.transparent;
    final Color finalcolor =
        isdark
            ? color
            : active
            ? Colors.teal
            : Colors.transparent;
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: AnimatedContainer(
          duration: motion.duration,
          curve: motion.curve,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: finalcolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
      ),
    );
  }
}
