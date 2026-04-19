import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
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
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  void _closeMenu() {
    if (_isMenuOpen) {
      setState(() => _isMenuOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              ConcaveNotchHeader(
                onMenuToggle: _toggleMenu,
                isMenuOpen: _isMenuOpen,
              ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _menuItem(context, "Home", "/"),
              const SizedBox(height: 24),
              _menuItem(context, "Dreadmoor", "/dreadmoor"),
              const SizedBox(height: 24),
              _menuItem(context, "Episode Tracker", "/tracker"),
              const SizedBox(height: 24),
              _menuItem(context, "Contact", "/contact"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        onClose();
        context.go(route);
      },
      child: const Text(
        '',
        style: TextStyle(fontSize: 28),
      ),
    ).copyWith(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE6EAF0),
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
      child: const Center(
        child: Text(
          '© BLACKMOON Studio',
          style: AppTextStyles.bodySecondary,
        ),
      ),
    );
  }
}
