import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CyanHeader extends StatelessWidget {
  final String title;
  const CyanHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    //
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    final BoxDecoration iconDecoration =
        isdark
            ? AppColors.appbarIconDecoration
            : AppColors.lightAppbarIconDecoration;
    return Material(
      color: isdark ? Colors.black : Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
          child: Row(
            children: [
              /// 🔹 Back button
              Container(
                height: 40,
                decoration: iconDecoration,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: !isdark ? Colors.black54 : Colors.white54,
                  ),
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                ),
              ),

              /// 🔹 Centered title
              Expanded(
                child: Center(
                  child: BlocProvider(
                    create: (_) => AppBloc()..add(StartGradientText(title)),
                    child: GradientText(
                      title,
                      gradientColors:
                          isdark
                              ? AppColors.darkGradient
                              : AppColors.lightGradient,
                    ),
                  ),
                ),
              ),

              /// 🔹 Spacer to balance back button width
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }
}
