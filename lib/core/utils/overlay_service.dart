import 'dart:async';

import 'package:flutter/material.dart';

class CoolToast {
  static OverlayEntry? _currentEntry;
  static Timer? _timer;

  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    // Remove existing toast immediately for "lag-free" feel
    _currentEntry?.remove();
    _timer?.cancel();

    _currentEntry = OverlayEntry(
      builder:
          (context) => _ToastWidget(
            message: message,
            isError: isError,
            onDismiss: () => _currentEntry?.remove(),
          ),
    );

    Overlay.of(context).insert(_currentEntry!);

    // Auto-dismiss after 3 seconds
    _timer = Timer(const Duration(seconds: 2), () {
      _currentEntry?.remove();
      _currentEntry = null;
    });
  }
}

/////
////
class _ToastWidget extends StatelessWidget {
  final String message;
  final bool isError;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.isError,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: -80, end: 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: child,
                );
              },
              child: GestureDetector(
                onVerticalDragStart: (_) => onDismiss(), // Swipe up to dismiss
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: isError ? const Color(0xFFFF5252) : Colors.green,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ), ////
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isError
                            ? Icons.warning_amber_rounded
                            : Icons.auto_awesome,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
