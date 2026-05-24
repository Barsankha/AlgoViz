import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Icon icon;
  final bool isp;
  final VoidCallback? onpressed;
  final String id;
  const CustomAppBar({
    super.key,
    required this.titleText,
    required this.icon,
    required this.isp,
    this.onpressed,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.select(
      (AppBloc b) => b.state.theme == AppTheme.dark,
    );

    // Compute decorations & gradient once here (based on current theme)
    final BoxDecoration iconDecoration =
        isDark
            ? AppColors.appbarIconDecoration
            : AppColors.lightAppbarIconDecoration;

    final List<Color> titleGradient =
        isDark ? AppColors.darkGradient : AppColors.lightGradient;
    return AppBar(
      surfaceTintColor: Colors.transparent,
      forceMaterialTransparency: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: iconDecoration,
          child: IconButton(
            onPressed: () async {
              if (isp) {
                Navigator.pop(context);
              } else {
                onpressed!.call();
              }
            },
            icon: icon,
            color: Colors.grey, //
          ),
        ),
      ),
      title: RepaintBoundary(
        child: BlocProvider(
          create: (context) => AppBloc()..add(StartGradientText(titleText)),
          child: GradientText(titleText, gradientColors: titleGradient),
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        if (isp)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: iconDecoration,
              child: BlocBuilder<AppBloc, AppState>(
                //  selector: (state) => state.bookmarkIds.contains(id),
                builder: (context, bookmarkIds) {
                  final isbookmark = bookmarkIds.bookmarkIds.contains(id);
                  return IconButton(
                    onPressed: () async {
                      context.read<AppBloc>().add(ToggleBookmark(id));
                    },
                    icon:
                        isbookmark
                            ? Icon(
                              Icons.bookmark,
                              color:
                                  isDark
                                      ? Colors.cyanAccent
                                      : Colors.tealAccent,
                            )
                            : Icon(Icons.bookmark_border),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.gradientColors});
  final String text;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ).createShader(bounds);
          },
          child: Text(
            state.displayText,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      },
    );
  }
}
