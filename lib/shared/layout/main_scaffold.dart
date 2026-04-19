import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive.dart';
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
          if (_isMenuOpen)
            Positioned.fill(
              child: _OverlayMenu(onClose: _closeMenu),
            ),
        ],
      ),
    );
  }
}

class _OverlayMenu extends StatelessWidget {
  final VoidCallback onClose;

  const _OverlayMenu({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/studio/blackmoon_symbol.png',
                    height: 56,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 28, color: AppColors.textPrimary),
                    onPressed: onClose,
                  ),
                ],
              ),
              const SizedBox(height: 80),
              // NAVIGATION (LEFT ALIGNED)
              _menuItem(context, "Home", "/"),
              _menuItem(context, "Dreadmoor", "/dreadmoor"),
              _menuItem(context, "Episode Tracker", "/tracker"),
              _menuItem(context, "Contact", "/contact"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: GestureDetector(
        onTap: () {
          onClose();
          context.go(route);
        },
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE6EAF0),
          ),
        ),
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
