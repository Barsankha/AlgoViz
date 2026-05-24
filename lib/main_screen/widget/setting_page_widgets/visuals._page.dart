import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/data_structure/hash/bloc/hash_bloc.dart';
import 'package:algov/main_screen/setting_page.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/motion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/card_title.dart';

class VisualsPage extends StatelessWidget {
  const VisualsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.read<AppBloc>().state.theme == AppTheme.dark;
    return Column(
      children: [AppearanceCard(isdark: isDark), ToggleCard(isdark: isDark)],
    );
  }
}

class AppearanceCard extends StatefulWidget {
  final bool isdark;
  const AppearanceCard({super.key, required this.isdark});

  @override
  State<AppearanceCard> createState() => _AppearanceCardState();
}

class _AppearanceCardState extends State<AppearanceCard> {
  @override
  Widget build(BuildContext context) {
    final Color color = widget.isdark ? Colors.white70 : Colors.black;
    return CardWidget(
      isdark: widget.isdark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          title('APPEARANCE MODE', color),
          const SizedBox(height: 12),
          // AspectRatio(
          //   aspectRatio: 16 / 9,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: widget.isdark ? const Color(0xFF1A2230) : Colors.white,
          //       borderRadius: BorderRadius.circular(14),
          //     ),
          //     clipBehavior: Clip.antiAlias,
          //     child: InkWell(
          //       onTap: () async {
          //         final picked = await ImageSourcePicker.pickImage(context);
          //         if (picked != null) {
          //           setState(() => image = picked);
          //         } //
          //       },
          //       child:
          //           image == null
          //               ? Center(
          //                 child: Icon(
          //                   Icons.image,
          //                   size: 100,
          //                   color:
          //                       widget.isdark
          //                           ? Colors.white38
          //                           : Colors.black.withValues(alpha: 0.3),
          //                 ),
          //               )
          //               : Image.file(
          //                 image!,
          //                 fit: BoxFit.cover,
          //                 width: double.infinity,
          //                 cacheWidth: 1080,
          //                 height: double.infinity,
          //               ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 12),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return Row(
                children: [
                  ModeButton(
                    'Dark',
                    Icons.dark_mode,
                    state.theme == AppTheme.dark,
                    AppTheme.dark,
                    SettingsView.accent,
                    isHash: false,
                  ),
                  ModeButton(
                    'Light',
                    Icons.light_mode,
                    state.theme == AppTheme.light,
                    AppTheme.light,
                    Colors.tealAccent,
                    isHash: false,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ModeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final dynamic theme;
  final Color iconColor;
  final bool isHash;

  const ModeButton(
    this.label,
    this.icon,
    this.active,
    this.theme,
    this.iconColor, {
    super.key,
    required this.isHash,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainerWidget(
      active: active,
      ontap: () {
        if (isHash) {
          context.read<HashBloc>().add(SwitchTypeEvent(theme));
        } else {
          context.read<AppBloc>().add(ThemeChanged(theme));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: iconColor)),
        ],
      ),
    );
  }
}
