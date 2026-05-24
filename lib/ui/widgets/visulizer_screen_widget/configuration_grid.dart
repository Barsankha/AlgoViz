import 'dart:async';
import 'package:algov/core/engine/controller/searching_controller.dart';
import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/data_structure/array/models/sort_item.dart';
import 'package:algov/ui/widgets/custom_widgets/config_item.dart';
import 'package:algov/ui/widgets/custom_widgets/custom_icon_button.dart';
import 'package:algov/ui/widgets/custom_widgets/sort_icons.dart';
import 'package:algov/ui/widgets/custom_widgets/speed_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigarationGrid extends StatelessWidget {
  final bool isCompact;
  final Algo algorithm;
  final VisualController controller;
  final bool isdark;
  const ConfigarationGrid({
    super.key,
    required this.isCompact,
    required this.algorithm,
    required this.controller,
    required this.isdark,
  });

  Future<void> _resetData() async {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth * (isCompact ? 0.45 : 0.4);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConfigItem(
                  isdark: isdark,
                  label: "ALGORITHM",
                  width: itemWidth,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isCompact ? 8 : 12,
                      vertical: isCompact ? 3 : 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(isCompact ? 6 : 8),
                    ),
                    child: Text(
                      algorithm.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isCompact ? 12 : 14,
                        color: isdark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isCompact ? 16 : 20),
            SpeedRow(
              isdark: isdark,
              controller: controller,
              isCompact: isCompact,
              availableWidth: constraints.maxWidth,
              algorithm: algorithm,
            ),
            SizedBox(height: isCompact ? 16 : 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConfigItem(
                  isdark: isdark,
                  label: "INPUT DATA",
                  width: itemWidth,
                  child: CustomIconButton(
                    isCompact: isCompact,
                    isdark: isdark,
                    onpressed: _resetData,
                    iconData: CupertinoIcons.arrow_counterclockwise,
                    text: "Reset",
                  ),
                ),
                if (controller is SearchAlgoController)
                  SortIcon(
                    isCompact: isCompact,
                    cont: controller as SearchAlgoController,
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
