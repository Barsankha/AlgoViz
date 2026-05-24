import 'package:algov/app/bloc/app_bloc.dart';
import 'package:algov/app/custom_app_bar.dart';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:algov/main_screen/widget/bottom_navbar.dart';
import 'package:algov/ui/widgets/app_widgets/backgroung_lob.dart';
import 'package:algov/ui/widgets/app_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
///

class ModernDrawerLayout extends StatefulWidget {
  const ModernDrawerLayout({super.key});

  @override
  State<ModernDrawerLayout> createState() => _ModernDrawerLayoutState();
}

class _ModernDrawerLayoutState extends State<ModernDrawerLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Animation Values
  late Animation<double> _contentScale;
  late Animation<double> _contentSlide;
  late Animation<double> _menuScale;
  late Animation<double> _menuSlide;
  late Animation<double> _cornerRadius;
  late final PageController _pageController;

  final ValueNotifier<int> pageIndexNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(
        milliseconds: 450,
      ), // Longer duration for spring effect
    );

    const curve = Curves.fastLinearToSlowEaseIn; //

    // Content moves RIGHT
    _contentSlide = Tween<double>(
      begin: 0.0,
      end: 280.0,
    ).animate(CurvedAnimation(parent: _controller, curve: curve));

    // Content shrinks slightly (2D Scale)
    _contentScale = Tween<double>(
      begin: 1.0,
      end: 0.88,
    ).animate(CurvedAnimation(parent: _controller, curve: curve));

    _menuSlide = Tween<double>(
      begin: -50.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: curve));

    // Menu grows slightly (Pop in effect)
    _menuScale = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: curve));

    // Smooth Corner Radius transition
    _cornerRadius = Tween<double>(
      begin: 0.0,
      end: 32.0,
    ).animate(CurvedAnimation(parent: _controller, curve: curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    pageIndexNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    if (_controller.value < 0.5) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<AppBloc>().state.theme == AppTheme.dark;
    final reducedMotion = context.select((AppBloc b) => b.state.reduceMotion);
    return Stack(
      children: [
        if (!reducedMotion) const Positioned.fill(child: BlobBackground()),

        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_menuSlide.value, 0),
              child: Transform.scale(
                scale: _menuScale.value,
                child: Opacity(
                  // Fade in menu as drawer opens
                  opacity: _controller.value.clamp(0.0, 1.0),
                  child: child,
                ),
              ),
            );
          },
          child: MenuContent(
            onTapItem: _toggleDrawer,
            controller: _controller,
            reducedMotion: reducedMotion,
            isdark: isDark,
          ),
        ),

        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_contentSlide.value, 0),
              child: Transform.scale(
                scale: _contentScale.value,
                alignment: Alignment.centerLeft, // Scale from left pivot
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_cornerRadius.value),
                  child: child,
                ),
              ),
            );
          },
          child: MainContent2(
            pageIndex: pageIndexNotifier,
            onMenuPressed: _toggleDrawer,
            controller: _pageController,
            pageNotifier: pageIndexNotifier,
          ),
        ),
      ],
    );
  }
}

class MenuContent extends StatelessWidget {
  final VoidCallback onTapItem;
  final AnimationController controller;
  final bool isdark;
  final bool reducedMotion;
  const MenuContent({
    super.key,
    required this.onTapItem,
    required this.controller,
    required this.isdark,
    required this.reducedMotion,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isdark ? Colors.cyanAccent : Colors.tealAccent;
    return SafeArea(
      child: Container(
        width: 280,
        padding: const EdgeInsets.only(left: 24, top: 40, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            const SizedBox(width: 16),
            DefaultTextStyle(
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              child: Text("DASHBOARD"),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: DrawerMenuItems(
                reducedMotion: reducedMotion,
                isdark: isdark,
                animationController: controller,
                color: color,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Divider(color: color, thickness: 1),
            ),
            DrawerItem(
              reducedMotion: reducedMotion,
              index: 8,
              icon: Icons.arrow_forward,
              title: "Exit",
              ontap: () {
                onTapItem();
              },
              animatedController: controller,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class MainContent2 extends StatelessWidget {
  final PageController controller;
  final ValueNotifier<int> pageNotifier;
  final VoidCallback onMenuPressed;
  final ValueNotifier<int> pageIndex;

  const MainContent2({
    super.key,
    required this.onMenuPressed,
    required this.controller,
    required this.pageNotifier,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        titleText: 'AlgoViz',
        icon: Icon(Icons.menu_rounded),
        isp: false,
        id: 'id',
        onpressed: onMenuPressed,
      ),
      body: MyHomeScreen(pageNotifier: pageIndex, controller: controller),
      bottomNavigationBar: CustomBottomNavBar(
        controller: controller,
        pageNotifier: pageNotifier,
      ),
    );
  }
}
