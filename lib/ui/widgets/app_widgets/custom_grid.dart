import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/routes.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGrid extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Widget path;
  final String title;
  final AnimType animType;
  final bool isgrid;
  const CustomGrid({
    super.key,
    required this.color,
    required this.icon,
    required this.path,
    required this.title,
    required this.animType,
    required this.isgrid,
  });

  @override
  Widget build(BuildContext context) {
    final bool isdark =
        context.select((AppBloc bloc) => bloc.state.theme) == AppTheme.dark;
    return GestureDetector(
      //
      onTap: () async {
        RouteAnim.push(
          Navigator.of(context, rootNavigator: true).context,
          path,
          animType,
        );
      },
      child: Container(
        width: 100,
        decoration:
            !isdark
                ? AppColors.lightpopularGridDecoration
                : BoxDecoration(
                  color:
                      isdark
                          ? AppColors.darkgrid
                          : Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: isgrid ? 40 : 30,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: isgrid ? 40 : 25),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: color.withValues(
                  alpha: 0.9,
                ), //isdark ? AppColors.darkHero : AppColors.darkgrid,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//