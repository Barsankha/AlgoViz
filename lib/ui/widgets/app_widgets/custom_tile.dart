import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:algov/main_screen/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlgorithmCard extends StatelessWidget {
  final String title;
  final String complexity;
  final String description;
  final IconData icon;
  final Color complexityColor;
  final VoidCallback? onTap;
  final bool isbookmarked;
  final String id;

  const AlgorithmCard({
    super.key,
    required this.title,
    required this.complexity,
    required this.description,
    required this.icon,
    required this.complexityColor,
    this.onTap,
    required this.isbookmarked,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = context.read<AppBloc>().state.theme;
    final bool isdark = appTheme == AppTheme.dark;
    // Pre-process title once (avoid doing in build repeatedly)
    final String displayTitle = title
        .replaceAll("Sort", "")
        .replaceAll("Search", "")
        .replaceAll("Algorithm", "");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isdark ? AppColors.darkTile : AppColors.lightTile,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              RepaintBoundary(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      isdark
                          ? AppColors.tileiconDecoration
                          : AppColors.lightTileiconDecoration,
                  child: Icon(
                    icon,
                    color: isdark ? const Color(0xFF00A3FF) : Colors.teal,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          displayTitle,
                          style: TextStyle(
                            color: isdark ? Colors.white : Colors.teal,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 8),
                        if (!isbookmarked)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: complexityColor.withValues(alpha: 0.5),
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color: complexityColor.withValues(alpha: 0.08),
                            ),
                            child: Text(
                              complexity,
                              style: TextStyle(
                                color: complexityColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              if (isbookmarked)
                GestureDetector(
                  onTap: () {
                    openSaved(context, id);
                  },
                  child: IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.cyanAccent),
                    onPressed: () {
                      context.read<AppBloc>().add(ToggleBookmark(id));
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
