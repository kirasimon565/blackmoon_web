import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../routing/routes.dart';
import '../widgets/concave_notch_header.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _closeMenu() {
    if (_isMenuOpen) {
      setState(() {
        _isMenuOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              ConcaveNotchHeader(onMenuToggle: _toggleMenu, isMenuOpen: _isMenuOpen),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // To ensure stacked pages like Home and Dreadmoor can fill height
                      SizedBox(
                        height: MediaQuery.of(context).size.height - (Responsive.isDesktop(context) ? 100 : 84),
                        child: widget.child,
                      ),
                      const _Footer(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Full Screen Overlay Menu
          if (_isMenuOpen && Responsive.isMobile(context))
            Positioned.fill(
              child: _MobileOverlayMenu(onClose: _closeMenu),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final String route;

  const _NavItem({required this.title, required this.route});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: Text(
          widget.title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: _isHovered ? AppColors.accent : AppColors.textPrimary,
            decoration: _isHovered ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}

class _MobileOverlayMenu extends StatelessWidget {
  final VoidCallback onClose;

  const _MobileOverlayMenu({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Header area mirroring the main header
            Container(
              height: 84,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withAlpha(230), // 0.9 * 255
                        BlendMode.srcATop,
                      ),
                      child: Image.asset(
                        'assets/images/studio/blackmoon_logo.png',
                        height: 64, // mobile size
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.textPrimary,
                      size: 28,
                    ),
                    onPressed: onClose,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _MobileNavItem(title: 'Home', route: AppRoutes.home, onClose: onClose),
                    const SizedBox(height: 32),
                    _MobileNavItem(title: 'Dreadmoor', route: AppRoutes.dreadmoor, onClose: onClose),
                    const SizedBox(height: 32),
                    _MobileNavItem(title: 'Episode Tracker', route: AppRoutes.tracker, onClose: onClose),
                    const SizedBox(height: 32),
                    _MobileNavItem(title: 'Contact', route: AppRoutes.contact, onClose: onClose),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String title;
  final String route;
  final VoidCallback onClose;

  const _MobileNavItem({
    required this.title,
    required this.route,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClose();
        context.go(route);
      },
      child: Text(
        title,
        style: AppTextStyles.h2,
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Text(
          '© BLACKMOON Studio',
          style: AppTextStyles.bodySecondary,
        ),
      ),
    );
  }
}
