import 'package:algov/core/utils/overlay_service.dart';
import 'package:algov/ui/widgets/app_widgets/cyan_header.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMe extends StatelessWidget {
  const ContactMe({super.key});

  Future<void> _handleLaunche(BuildContext context, Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      CoolToast.show(
        // ignore: use_build_context_synchronously
        context,
        "Could not open the request application",
        isError: true,
      );
    }
  }

  @override
  build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CyanHeader(title: "Contact me"),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                letterSpacing: 1.2,
              ),
              child: Text("Help & FEEDBACK"),
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.headset_mic_outlined, color: Colors.blue),
            title: const Text("Contact Support"),
            subtitle: const Text("Talk to me"),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () {
              _handleLaunche(
                context,
                Uri(
                  scheme: 'malito',
                  path: 'barsankha25@gmail.com',
                  queryParameters: {'subject': 'Support Request'},
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.headset_mic_outlined, color: Colors.blue),
            title: const Text("Report a Bug"),
            subtitle: const Text("Help me imProve the Experience"),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () {
              _handleLaunche(
                context,
                Uri(
                  scheme: 'malito',
                  path: 'barsankha25@gmail.com',
                  queryParameters: {'subject': 'Bug Report:[Issue Title]'},
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(Icons.star_border, color: Colors.cyanAccent);
            }),
          ),
          const SizedBox(height: 24),
          Text(
            "Rate the App at playStore",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
