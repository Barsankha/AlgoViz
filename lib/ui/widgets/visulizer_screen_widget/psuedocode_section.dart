import 'package:algov/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// pseudocode_section.dart

class BuildPseudoCodeSection extends StatelessWidget {
  final bool isCompact;
  final bool isdark;
  final List<String> pseudocodeLines;

  const BuildPseudoCodeSection({
    super.key,
    this.isCompact = false,
    required this.isdark,
    required this.pseudocodeLines,
  });

  // static const _highlightIndices = <int>[5, 6];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AppBloc>().add(ExpandedPsuedo()),
      child: Container(
        padding: EdgeInsets.all(isCompact ? 12 : 16),
        decoration: BoxDecoration(
          color:
              isdark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(isCompact ? 10 : 12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header row – only this part rebuilds on tap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "</> ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.cyanAccent,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const Text(
                      "Pseudocode",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AppBloc, AppState>(
                  buildWhen: (prev, curr) => prev.isExpanded != curr.isExpanded,
                  builder: (context, state) {
                    return AnimatedRotation(
                      turns: state.isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOut,
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.cyanAccent,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),
            // Content – only rebuilds when expanded state changes
            BlocBuilder<AppBloc, AppState>(
              buildWhen:
                  (previous, current) =>
                      previous.isExpanded != current.isExpanded,
              builder: (context, state) {
                final isExpanded = state.isExpanded;

                return AnimatedSize(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeInOutCubic,
                  alignment: Alignment.topCenter,
                  child:
                      isExpanded
                          ? ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 340),
                            child: _buildCodeContainer(),
                          )
                          : const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isdark ? Colors.black.withValues(alpha: 0.94) : Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        cacheExtent: 800, // ← helps smooth scrolling
        addAutomaticKeepAlives: false, // we don't need keep-alive here
        itemCount: pseudocodeLines.length,
        itemBuilder: (context, index) {
          //    final isHighlighted = _highlightIndices.contains(index);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.2),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Text(
                  pseudocodeLines[index],
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.4,
                    color: isdark ? Colors.white70 : Colors.black87,
                    height: 1.42,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
