import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/main_screen/setting_page.dart';
import 'package:algov/main_screen/widget/setting_page_widgets/card_title.dart';
import 'package:algov/ui/widgets/custom_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isdark = context.select(
      (AppBloc b) => b.state.theme == AppTheme.dark,
    );
    final size = MediaQuery.sizeOf(context);
    final isCompact = size.shortestSide < 600;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AboutCard(isdark: isdark),
        ShareAppButton(isdark: isdark, isCompact: isCompact),
        const SizedBox(height: 15),
        Lincencense(isdark: isdark),
      ],
    );
  }
}

class Lincencense extends StatelessWidget {
  final bool isdark;
  const Lincencense({super.key, required this.isdark});

  @override
  Widget build(BuildContext context) {
    final Color color = isdark ? Colors.cyanAccent : Colors.teal;
    return CardWidget(
      isdark: isdark,
      child: ListTile(
        trailing: Icon(Icons.arrow_forward_ios, color: color),
        title: Text("Open Source Licenses", style: TextStyle(color: color)),
        onTap: () {
          showLicensePage(
            context: context,
            applicationName: "AlgoViz",
            applicationVersion: "1.0.0",
            applicationLegalese: "Copyright \u00A9 2026",
            useRootNavigator: true,
          );
        },
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final bool isdark;
  const AboutCard({super.key, required this.isdark});

  @override
  Widget build(BuildContext context) {
    final Color color = isdark ? Colors.white : Colors.black;
    return CardWidget(
      isdark: isdark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title('ABOUT ALGOVIZ', color),
          const SizedBox(height: 16),
          Text(
            'Version 1.0.0',
            style: TextStyle(
              color: color, //Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Interactive algorithm visualizations for learning sorting, pathfinding, graphs, and more.\n\nBuilt with Flutter ❤️',
            style: TextStyle(color: color, fontSize: 15),
          ),
          const SizedBox(height: 12),
          // TextButton(

          // onPressed: () {
          //  RouteAnim.push(context, ContactMe(), AnimType.slide);
          //},
          //child:
          Text(
            'Made by Sankha',
            style: TextStyle(
              color: isdark ? SettingsView.accent : Colors.teal,
              fontSize: 16,
            ),
          ),
          //   ),
        ],
      ),
    );
  }
}

class AppShareService {
  static Future<void> shareApp(BuildContext context) async {
    // 1. Define your store links
    const String packageName = "com.algov.visualizer";
    const String androidUrl =
        "https://play.google.com/store/apps/details?id=$packageName";
    //    const String iosUrl = "https://apps.apple.com/app/id123456789";

    // 2. Determine which link to us
    //  final String appUrl = Platform.isAndroid ? androidUrl : iosUrl;

    final box = context.findRenderObject() as RenderBox?;
    final sharePosition = box!.localToGlobal(Offset.zero) & box.size;

    final String message =
        "Check out this amazing app! It helps me stay productive. 🚀 \n\nDownload it here: $androidUrl";

    // 5. Trigger the share sheet
    await SharePlus.instance.share(
      ShareParams(
        text: message,
        subject: "Download My App",
        sharePositionOrigin: sharePosition,
      ),
    );
  }
}

class ShareAppButton extends StatelessWidget {
  final bool isdark;
  final bool isCompact;
  const ShareAppButton({
    super.key,
    required this.isdark,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      isdark: isdark,
      onpressed: () {
        AppShareService.shareApp(context);
      },
      isCompact: isCompact,
      iconData: Icons.share,
      text: "Share with Friends",
    );
  }
}
