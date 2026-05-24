import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/main_screen/setting_page.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/card_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleCard extends StatelessWidget {
  final bool isdark;
  const ToggleCard({super.key, required this.isdark});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.read<AppBloc>().state.theme == AppTheme.dark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    return CardWidget(
      isdark: isdark,
      child: Column(
        children: [
          BlocSelector<AppBloc, AppState, bool>(
            selector: (state) => state.theme == AppTheme.light,
            builder: (context, isDark) {
              return ToggleRow(
                value: isDark,
                textColor: textColor,
                title: 'Glass Effects',
                subtitle: 'Enable translucent blurs',
                onchange: (value) {
                  context.read<AppBloc>().add(
                    ThemeChanged(value ? AppTheme.light : AppTheme.dark),
                  );
                },
              );
            },
          ),
          SizedBox(height: 12),
          BlocSelector<AppBloc, AppState, bool>(
            selector: (state) => state.reduceMotion,
            builder: (context, reduceMotion) {
              return ToggleRow(
                value: reduceMotion,
                textColor: textColor,
                title: 'Reduce Motion',
                subtitle: 'Simplify animations',
                onchange: (value) {
                  context.read<AppBloc>().add(ReducedMotion());
                },
              );
            },
          ),
          SizedBox(height: 12),
          BlocSelector<AppBloc, AppState, bool>(
            selector: (state) => state.isImage,
            builder: (context, isImage) {
              return ToggleRow(
                value: isImage,
                textColor: textColor,
                title: 'Default BackGround',
                subtitle: 'Simplify background',
                onchange: (value) {
                  context.read<AppBloc>().add(IsImage());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color textColor;
  final bool value;
  final void Function(bool) onchange;

  const ToggleRow({
    required this.title,
    required this.subtitle,
    required this.onchange,
    super.key,
    required this.textColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: textColor, fontSize: 16)),
            Text(subtitle, style: TextStyle(color: textColor, fontSize: 13)),
          ],
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: CupertinoSwitch(
            value: value,
            activeTrackColor: SettingsView.accent,
            onChanged: onchange,
          ),
        ),
      ],
    );
  }
}

class MotionConfig {
  final bool reduce;

  const MotionConfig(this.reduce);

  Curve get curve => reduce ? Curves.linear : Curves.easeOutCubic;

  Duration get duration =>
      reduce ? Duration.zero : const Duration(milliseconds: 300);

  Offset get slideBegin => reduce ? Offset.zero : const Offset(-1.5, 0);
}
