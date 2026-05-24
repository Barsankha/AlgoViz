import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/routes.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/constants/constant.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/motion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerMenuItems extends StatelessWidget {
  final AnimationController animationController;
  final Color color;
  final bool isdark;
  final bool reducedMotion;
  const DrawerMenuItems({
    super.key,
    required this.animationController,
    required this.color,
    required this.isdark,
    required this.reducedMotion,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 60,
      physics: BouncingScrollPhysics(),
      itemCount: drawerItem.length,
      itemBuilder: (context, index) {
        return DrawerItem(
          reducedMotion: reducedMotion,
          index: index,
          icon: drawerItem[index]['icon'],
          title: drawerItem[index]['title'],
          animatedController: animationController,
          ontap: () {
            RouteAnim.push(
              context,
              drawerItem[index]['ontap'],
              AnimType.matrix,
            );
          },
        );
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? ontap;
  final int index;
  final AnimationController animatedController;

  final bool reducedMotion;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.ontap,
    required this.index,
    required this.animatedController,

    required this.reducedMotion,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<AppBloc>().state.theme == AppTheme.dark;
    final Color textcolor = isDark ? Colors.white : Colors.black;
    final Color iconcolor = isDark ? Colors.cyanAccent : Colors.tealAccent;
    final motion = MotionConfig(reducedMotion);
    final double begin = (index * 0.1).clamp(0.0, 1.0);
    final double end = (begin + 0.5).clamp(0.0, 1.0);

    final Animation<double> animation = CurvedAnimation(
      parent: animatedController,
      curve: Interval(begin, end, curve: motion.curve),
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: motion.slideBegin,
        end: Offset.zero,
      ).animate(animation),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ontap,
          child: Row(
            children: [
              Icon(icon, size: 30, color: iconcolor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
