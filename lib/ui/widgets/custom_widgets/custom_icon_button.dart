import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final bool isdark;
  final VoidCallback onpressed;
  final bool isCompact;
  final IconData iconData;
  final String text;

  const CustomIconButton({
    super.key,
    required this.isdark,
    required this.onpressed,
    required this.isCompact,
    required this.iconData,
    required this.text,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with TickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  late final AnimationController _effectController;
  late final Animation<double> _pulseOutAnimation; // For Insert (grow elastic)
  late final Animation<double> _pulseInAnimation; // For Delete (squish)
  late final Animation<double> _rotationAnimation; // For Reverse (full spin)
  late final Animation<Offset> _slideAnimation; // For Traverse (slide right)

  @override
  void initState() {
    super.initState();

    // Press feedback scale (subtle press down)
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.94,
      upperBound: 1.0,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutCubic),
    );
    _scaleController.value = 1.0;

    // Icon-specific effect animation
    _effectController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _pulseOutAnimation = Tween<double>(begin: 1.0, end: 1.35).animate(
      CurvedAnimation(parent: _effectController, curve: Curves.elasticOut),
    );

    _pulseInAnimation = Tween<double>(begin: 1.0, end: 0.75).animate(
      CurvedAnimation(parent: _effectController, curve: Curves.easeInBack),
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _effectController, curve: Curves.linear));

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.4, 0),
    ).animate(
      CurvedAnimation(parent: _effectController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _effectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = widget.isdark ? Colors.cyanAccent : Colors.teal;
    final double borderRadius = widget.isCompact ? 14.0 : 18.0;
    final double iconSize = widget.isCompact ? 20.0 : 26.0;
    final double fontSize = widget.isCompact ? 14.0 : 16.0;
    final EdgeInsets padding = EdgeInsets.symmetric(
      horizontal: widget.isCompact ? 20.0 : 28.0,
      vertical: widget.isCompact ? 12.0 : 16.0,
    );

    // Base icon
    final Widget baseIcon = Icon(
      widget.iconData,
      color: accentColor,
      size: iconSize,
    );

    // Apply icon-specific animation
    Widget animatedIcon = baseIcon;
    final String lowerText = widget.text.toLowerCase();

    if (lowerText == 'reverse' || lowerText == 'reset') {
      animatedIcon = RotationTransition(
        turns: _rotationAnimation,
        child: baseIcon,
      );
    } else if (lowerText == 'traverse' ||
        lowerText == 'push' ||
        lowerText == 'enqueue') {
      animatedIcon = SlideTransition(
        position: _slideAnimation,
        child: baseIcon,
      );
    } else if (lowerText.contains('insert') ||
        lowerText == 'pop' ||
        lowerText == 'dequeue') {
      animatedIcon = ScaleTransition(
        scale: _pulseOutAnimation,
        child: baseIcon,
      );
    } else if (lowerText.contains('delete') || lowerText == 'clear') {
      animatedIcon = ScaleTransition(scale: _pulseInAnimation, child: baseIcon);
    }
    // Other buttons get only the press scale feedback

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      splashColor: accentColor.withValues(alpha: 0.3),
      highlightColor: accentColor.withValues(alpha: 0.15),
      onTap: widget.onpressed,
      onTapDown: (_) {
        _scaleController.reverse();
        _effectController
            .forward(from: 0.0)
            .then((_) => _effectController.reverse());
      },
      onTapUp: (_) {
        _scaleController.forward();
      },
      onTapCancel: () {
        _scaleController.forward();
        _effectController.reset();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.6),
              width: 1.4,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              animatedIcon,
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: TextStyle(
                  color: accentColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
