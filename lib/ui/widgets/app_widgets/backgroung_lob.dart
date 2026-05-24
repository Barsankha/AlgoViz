import 'dart:math' as math;
import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//File? image;

class BlobBackground extends StatelessWidget {
  const BlobBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.select(
      (AppBloc b) => b.state.theme == AppTheme.dark,
    );
    // final bool isImage = context.watch<AppBloc>().state.isImage;
    return Container(
      color: !isDark ? Colors.white : Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // if (!isImage && image != null) {
          //   return SizedBox(
          //     width: constraints.maxHeight.clamp(300.0, 600.0),
          //     height: constraints.maxWidth,
          //     child: Image.file(image!, fit: BoxFit.cover),
          //   );
          // }
          //  else {
          return SizedBox(
            width: constraints.maxHeight.clamp(300.0, 600.0),
            height: constraints.maxWidth,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Large purple/teal blob (top-left dominant)
                ResponsiveBlob(
                  angle: math.pi / 4,
                  size: 350,
                  top: -120,
                  left: -120,
                  color:
                      isDark
                          ? Colors.purpleAccent.withValues(alpha: 0.35)
                          : Colors.purple.withValues(alpha: 0.2),
                ),

                // Medium teal blob (top-right)
                ResponsiveBlob(
                  size: 300,
                  top: -60,
                  right: -100,
                  color:
                      isDark
                          ? Colors.teal.withValues(alpha: 0.45)
                          : Colors.teal.withValues(alpha: 0.2),
                ),

                // Rotated indigo blob (mid-left)
                ResponsiveBlob(
                  size: 280,
                  top: 100,
                  left: -50,
                  angle: math.pi / 6,
                  color:
                      isDark
                          ? Colors.indigo.withValues(alpha: 0.3)
                          : Colors.indigo.withValues(alpha: 0.2),
                ),

                // Bottom-right accent blob
                ResponsiveBlob(
                  size: 320,
                  bottom: 120,
                  right: -1,
                  color:
                      isDark
                          ? Colors.tealAccent.withValues(alpha: 0.25)
                          : Colors.teal.withValues(alpha: 0.3),
                ),
              ],
            ),
          );
          //  }
        },
      ),
    );
  }
}

class ResponsiveBlob extends StatelessWidget {
  /// Base values (designed for a ~375px wide screen, e.g. iPhone SE/8)
  final double size;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Color color;
  final double? angle; // Optional rotation in radians (null = no rotation)

  const ResponsiveBlob({
    super.key,
    required this.size,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.color,
    this.angle,
  });

  @override
  Widget build(BuildContext context) {
    // Compute scale once per rebuild (very cheap – MediaQuery is cached)
    final double scale = MediaQuery.of(context).size.width / 375.0;

    final double sized = size * scale;

    final Widget blob = Container(
      width: sized,
      height: sized,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );

    final Widget child =
        angle != null ? Transform.rotate(angle: angle!, child: blob) : blob;

    return Positioned(
      top: top != null ? top! * scale : null,
      bottom: bottom != null ? bottom! * scale : null,
      left: left != null ? left! * scale : null,
      right: right != null ? right! * scale : null,
      child: child,
    );
  }
}

// class ImageSourcePicker {
//   static final ImagePicker picker = ImagePicker();
//   static Future<File?> pickImage(BuildContext context) async {
//     void pick(ImageSource source) async {
//       final XFile? file = await picker.pickImage(
//         source: source,
//         imageQuality: 80,
//       );
//       // ignore: use_build_context_synchronously
//       Navigator.pop(context, file != null ? File(file.path) : null);
//     }

//     return showModalBottomSheet<File?>(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return SizedBox(
//           height: 100,
//           width: double.infinity,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               buildPickerOption(
//                 context,
//                 icon: Icons.camera_alt,
//                 label: 'Camera',
//                 onTap: () async {
//                   pick(ImageSource.camera);
//                 },
//               ),
//               buildPickerOption(
//                 context,
//                 icon: Icons.image,
//                 label: 'Image',
//                 onTap: () async {
//                   pick(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   static Widget buildPickerOption(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 40),
//           const SizedBox(height: 8),
//           Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }
// }
