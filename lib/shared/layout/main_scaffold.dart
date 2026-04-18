import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';
import '../../routing/routes.dart';
import 'responsive_container.dart';

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
              _Header(onMenuToggle: _toggleMenu, isMenuOpen: _isMenuOpen),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.child,
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

class _Header extends StatelessWidget {
  final VoidCallback onMenuToggle;
  final bool isMenuOpen;

  const _Header({required this.onMenuToggle, required this.isMenuOpen});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Container(
      color: AppColors.background,
      height: 80,
      child: ResponsiveContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => context.go(AppRoutes.home),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(230), // 0.9 * 255 ≈ 230
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(
                    'assets/images/studio/blackmoon_logo.png',
                    height: 40,
                  ),
                ),
              ),
            ),

            // Navigation
            if (isDesktop)
              Row(
                children: [
                  _NavItem(title: 'Home', route: AppRoutes.home),
                  const SizedBox(width: 32),
                  _NavItem(title: 'Dreadmoor', route: AppRoutes.dreadmoor),
                  const SizedBox(width: 32),
                  _NavItem(title: 'Episode Tracker', route: AppRoutes.tracker),
                  const SizedBox(width: 32),
                  _NavItem(title: 'Contact', route: AppRoutes.contact),
                ],
              )
            else
              IconButton(
                icon: Icon(
                  isMenuOpen ? Icons.close : Icons.menu,
                  color: AppColors.textPrimary,
                  size: 28,
                ),
                onPressed: onMenuToggle,
              ),
          ],
        ),
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
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withAlpha(230),
                      BlendMode.srcATop,
                    ),
                    child: Image.asset(
                      'assets/images/studio/blackmoon_logo.png',
                      height: 40,
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
