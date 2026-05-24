import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/routes.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/constants/constant.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:algov/ui/widgets/app_widgets/custom_grid.dart';
import 'package:algov/ui/widgets/app_widgets/cyan_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGridPage extends StatelessWidget {
  const CustomGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    return Material(
      color:
          isdark
              ? Colors.black
              : AppColors.lightAppbarIconBg, // replaces scaffold background
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            /// 🔹 Header with back arrow//
            const CyanHeader(title: "Categories"),

            /// 🔹 Grid
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      final item = categories[index];
                      return CustomGrid(
                        color: item['color'],
                        icon: item['icon'],
                        path: item['path'],
                        title: item['title'],
                        isgrid: true,
                        animType: AnimType.fade,
                      );
                    },
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
