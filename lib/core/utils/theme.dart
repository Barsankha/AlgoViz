import 'package:flutter/material.dart';

class AppStyles {
  static const _shadowOffset = Offset(0, 0);
  static const _shadowBlur = 4.0;

  static BoxShadow shadow(double opacity) {
    return BoxShadow(
      color: const Color(0xFF00D1FF).withValues(alpha: opacity),
      offset: _shadowOffset,
      blurRadius: _shadowBlur,
    );
  }

  static Text textStyle(
    String text,
    double size,
    Color color,
    FontWeight weight,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        fontStyle: FontStyle.italic,
      ),
      maxLines: 1,
    );
  }
}

class AppColors {
  // ===== DARK (original) =====
  static const darkGradient = [
    Colors.white,
    Colors.cyanAccent,
    Colors.cyan,
    Colors.blue,
  ];

  static const darkgrid = Color(0xFF12161B);
  static const darkHero = Colors.white;
  static const darkHeroit = Colors.white70;
  static const darkTile = Color(0xFF072630);

  static const darkDrawerItem = Colors.cyanAccent;

  static const darkActive = Color(0xFF00D1FF);

  static BoxDecoration appbarIconDecoration = BoxDecoration(
    color: const Color(0xFF1A1F24),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.white10),
  );

  static BoxDecoration darkpopulargridDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey.shade800, width: 1.5),
    borderRadius: BorderRadius.circular(15),
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Colors.black,
        Color(0xFF003333),
        Colors.cyanAccent.shade700,
        Colors.cyan.shade700,
      ],
      stops: const [0.1, 0.4, 0.8, 1.0],
    ),
  );

  static BoxDecoration tileiconDecoration = BoxDecoration(
    color: const Color(0xFF0B1E27),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF00A3FF).withValues(alpha: 0.4),
        blurRadius: 8,
        spreadRadius: 1,
      ),
    ],
  );
  // ===== LIGHT (teal version) =====
  static const lightGradient = [
    Color(0xFFE6F7F8),
    Colors.tealAccent,
    Colors.teal,
    Colors.greenAccent,
  ];

  static const lightblack = Colors.black;
  static const lightTile = Color(0xFFE0F2F1);
  static const lightAppbarIconBg = Color(0xFFE0F7FA);
  static const lightActive = Color(0xFF00897B);

  static BoxDecoration lightpopularGridDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey.shade200, width: 1),
    borderRadius: BorderRadius.circular(16),
    gradient: AppColors.tileGradientLight,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ],
  );
  static const tileGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFEFCFA),
      Color(0xFFFAF5F0),
      Color(0xFFF5EDE5),
    ],
    stops: [0.0, 0.4, 0.75, 1.0],
  );
  static BoxDecoration lightTileiconDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      // Keep the signature blue/cyan glow but softer for light theme
      BoxShadow(
        color: const Color(0xFF00A3FF).withValues(alpha: 0.25),
        blurRadius: 12,
        spreadRadius: 2,
      ),
      // Add subtle gray elevation shadow – essential in light themes for depth
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration lightAppbarIconDecoration = BoxDecoration(
    color: const Color(
      0xFFF8F9FA,
    ), // Very light gray-white to avoid pure white blending
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.black.withValues(alpha: 0.12)),
    boxShadow: [
      // Light elevation to make it feel raised (common in light themes)
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
