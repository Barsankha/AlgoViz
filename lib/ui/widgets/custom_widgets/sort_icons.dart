import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortIcon extends StatelessWidget {
  final bool isCompact;
  final SearchAlgoController cont;

  const SortIcon({super.key, required this.isCompact, required this.cont});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (prev, cur) => prev.isList != cur.isList,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SortButton(
              icon: Icons.north_rounded,
              isSelected: !state.isList,
              onTap: () async {
                context.read<AppBloc>().add(const TogggleList());
                await cont.sortA();
              },
              isCompact: isCompact,
            ),
            SizedBox(width: isCompact ? 6 : 10),
            SortButton(
              icon: Icons.south_rounded,
              isSelected: state.isList,
              onTap: () async {
                context.read<AppBloc>().add(const TogggleList());
                await cont.sortD();
              },
              isCompact: isCompact,
            ),
          ],
        );
      },
    );
  }
}

class SortButton extends StatelessWidget {
  final bool isSelected;
  final bool isCompact;
  final VoidCallback onTap;
  final IconData icon;
  const SortButton({
    super.key,
    required this.isSelected,
    required this.isCompact,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: Container(
          padding: EdgeInsets.all(isCompact ? 6 : 8),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? Colors.cyan.withValues(alpha: 0.2)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(isCompact ? 8 : 10),
            border: Border.all(
              color:
                  isSelected ? Colors.cyan : Colors.cyan.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: isSelected ? [AppStyles.shadow(0.3)] : [],
          ),
          child: Icon(
            icon,
            color:
                isSelected ? Colors.cyan : Colors.cyan.withValues(alpha: 0.5),
            size: isCompact ? 18 : 20,
          ),
        ),
      ),
    );
  }
}
