import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function(String)? onSearchchanged;
  final TextEditingController? controller;
  final String hintText;
  final void Function()? ontap;
  const CustomSearchBar({
    super.key,
    this.onSearchchanged,
    this.controller,
    required this.hintText,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isdark =
        context.select((AppBloc bloc) => bloc.state.theme) == AppTheme.dark;
    final BoxDecoration boxDecoration =
        isdark
            ? BoxDecoration(
              color: const Color(0xFF0F1318),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [AppStyles.shadow(0.0)],
            )
            : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00C4CC).withValues(alpha: 0.16),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: boxDecoration,
      child: TextField(
        onTap: ontap,
        controller: controller,
        style: TextStyle(color: !isdark ? Colors.black : Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: !isdark ? Colors.black : Colors.grey),
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.search,
            color: isdark ? Color(0xFF00D1FF) : Colors.teal,
          ),
        ),
        onChanged: onSearchchanged,
      ),
    );
  }
}
