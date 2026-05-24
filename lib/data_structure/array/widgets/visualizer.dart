import 'dart:ui';

import 'package:algov/core/engine/controller/visual_controller.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:flutter/material.dart';

class ArrayGrid extends StatelessWidget {
  final bool isCompact;
  final VisualController controller;
  final bool isDark;

  const ArrayGrid({
    super.key,
    required this.isCompact,
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return LayoutBuilder(
            // Added to get available width
            builder: (context, constraints) {
              final itemCount = controller.items.length;
              if (itemCount == 0) return const SizedBox.shrink();
              final minBarWidth = isCompact ? 10.0 : 15.0;
              final maxBarWidth = isCompact ? 25.0 : 35.0;

              final spacingFactor = 12.0;
              final totalSpacing = (itemCount - 1) * spacingFactor;
              final availableForBars = constraints.maxWidth - totalSpacing;

              final idealBarWidth = availableForBars / itemCount - 3;

              final effectiveBarWidth = idealBarWidth.clamp(
                minBarWidth,
                maxBarWidth,
              );

              return SingleChildScrollView(
                // Added horizontal scroll to handle overflow
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:
                      controller.items.map((item) {
                        final maxValue =
                            controller.items
                                .map((e) => e.value)
                                .reduce((a, b) => a > b ? a : b)
                                .toDouble();
                        final color = _getBarColor(item);
                        final maxBarHeight =
                            constraints.maxHeight - (isCompact ? 28 : 36);

                        final normalizedHeight =
                            (item.value / maxValue) * maxBarHeight;

                        final targetHeight = normalizedHeight.clamp(
                          8.0,
                          maxBarHeight,
                        );
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: spacingFactor / 2,
                          ), // ← Increased from 2.0 (half of spacingFactor)
                          child: AnimatedSlide(
                            key: ValueKey(item.hashCode),
                            offset:
                                item.isActive
                                    ? const Offset(0.15, 0.0)
                                    : Offset.zero,
                            duration: const Duration(milliseconds: 80),
                            curve: Curves.easeIn,
                            child: AnimatedBar(
                              key: ValueKey(item.hashCode),
                              value: item.value,
                              color: color,
                              duration: controller.animDuration,
                              isActive: item.isActive,
                              isCompact: isCompact,
                              barWidth: effectiveBarWidth,
                              barHeight: targetHeight, // Pass dynamic width
                            ),
                          ),
                        );
                      }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getBarColor(dynamic item) {
    if (controller.type == "Search") {
      return controller.isStarted
          ? (item.isFound
              ? Colors.greenAccent
              : (item.isActive ? Colors.orangeAccent : Colors.cyanAccent))
          : Colors.grey;
    } else {
      return controller.isStarted
          ? (controller.isSorting
              ? (item.isActive ? Colors.orangeAccent : Colors.cyanAccent)
              : Colors.greenAccent)
          : Colors.grey;
    }
  }
}

// Custom Tween for BarAnimValues
class AnimatedBar extends StatelessWidget {
  final int value;
  final double barHeight;
  final double barWidth;
  final Duration duration;
  final Color color;
  final bool isActive;
  final bool isCompact;

  const AnimatedBar({
    super.key,
    required this.value,
    required this.barHeight,
    required this.barWidth,
    required this.duration,
    required this.color,
    required this.isActive,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize =
        isActive
            ? (isCompact ? 12 : 14)
            : (isCompact
                ? 10
                : 12); //(barWidth / 2).clamp(isCompact ? 9.0 : 11.0, 16.0);

    final showLabel = true; //barHeight > 40 && barWidth > 10;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showLabel)
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color, //Colors.white,
            ),
          ),
        SizedBox(height: isCompact ? 4 : 6),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: barHeight, end: barHeight),
          duration: duration,
          curve: Curves.easeIn,
          builder: (_, h, __) {
            return Container(
              width: barWidth,
              height: h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
                boxShadow: isActive ? [AppStyles.shadow(0.6)] : [],
              ),
            );
          },
        ),
      ],
    );
  }
}

class BarAnimValues {
  final double height;
  final Color color;
  final List<BoxShadow> shadows;
  final double textSize;

  const BarAnimValues({
    required this.height,
    required this.color,
    required this.shadows,
    required this.textSize,
  });

  static BarAnimValues lerp(BarAnimValues a, BarAnimValues b, double t) {
    return BarAnimValues(
      height: lerpDouble(a.height, b.height, t) ?? a.height,
      color: Color.lerp(a.color, b.color, t) ?? a.color,
      shadows: BoxShadow.lerpList(a.shadows, b.shadows, t) ?? a.shadows,
      textSize: lerpDouble(a.textSize, b.textSize, t) ?? a.textSize,
    );
  }
}
