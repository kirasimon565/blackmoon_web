import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  static MainScaffoldState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainScaffoldState>();
  }

  @override
  State<MainScaffold> createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  bool _isMenuOpen = false;

  void toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  void closeMenu() {
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
          // Global Persistent Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/fog_main.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: AppColors.background),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColors.background.withAlpha((0.85 * 255).toInt()),
            ),
          ),
          
          // Main Content
          widget.child,

          // Invisible overlay to close the menu
          if (_isMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: closeMenu,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  color: Colors.black.withAlpha(120), // Subtle dimming 
                ),
              ),
            ),

          // 🔥 SYSTEM CONCAVE MENU
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            // 90.0 anchors it exactly below the 90px tall SharedSliverAppBar
            top: _isMenuOpen ? 90.0 : 70.0, 
            right: 0.0, // Flush against the right edge
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isMenuOpen ? 1.0 : 0.0, 
              child: IgnorePointer(
                ignoring: !_isMenuOpen, 
                child: const _SystemMenuPanel(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// THE SYSTEM PANEL DESIGN
// ==========================================
class _SystemMenuPanel extends StatelessWidget {
  const _SystemMenuPanel();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SystemPanelPainter(),
      child: Container(
        width: 240.0, // Slightly wider to match left-aligned aesthetic
        padding: const EdgeInsets.only(top: 32, bottom: 56, left: 40, right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Left aligned
          children: [
            _SystemNavItem(title: "HOME", route: "/", onClose: (context.findAncestorStateOfType<MainScaffoldState>())?.closeMenu),
            const SizedBox(height: 36), // Deep breathing room
            _SystemNavItem(title: "DREADMOOR", route: "/dreadmoor", onClose: (context.findAncestorStateOfType<MainScaffoldState>())?.closeMenu),
            const SizedBox(height: 36),
            _SystemNavItem(title: "TRACKER", route: "/tracker", onClose: (context.findAncestorStateOfType<MainScaffoldState>())?.closeMenu),
            const SizedBox(height: 36),
            _SystemNavItem(title: "CONTACT", route: "/contact", onClose: (context.findAncestorStateOfType<MainScaffoldState>())?.closeMenu),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// CUSTOM PAINTER (FOR SHARP EDGES & BORDER)
// ==========================================
class _SystemPanelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    
    // Top Right -> Top Left -> Bottom Left
    path.moveTo(size.width, 0); 
    path.lineTo(0, 0); 
    path.lineTo(0, size.height); 

    // Notch math: Aligns exactly with the 38px hamburger icon that has 24px padding.
    // 24 + (38 / 2) = 43px from the right edge.
    final notchCenterX = size.width - 43.0; 
    final notchWidth = 24.0;
    final notchDepth = 14.0;

    // Bottom Edge extending to the start of the notch
    path.lineTo(notchCenterX - notchWidth / 2, size.height);
    
    // The Concave Incision (Tight radius, sharp curves inward)
    path.quadraticBezierTo(
      notchCenterX, size.height - notchDepth * 1.5, // Control point pulls sharply up
      notchCenterX + notchWidth / 2, size.height
    );
    
    // Finish bottom edge -> Top Right
    path.lineTo(size.width, size.height); 
    path.lineTo(size.width, 0); 
    path.close();

    // 1. Draw Flat Background
    final fillPaint = Paint()
      ..color = AppColors.backgroundSecondary // Base UI dark tone, no transparency
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 2. Draw 1px Incision Border
    final borderPaint = Paint()
      ..color = Colors.white.withAlpha(40) // Subtle but visible
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// SYSTEM NAV ITEM
// ==========================================
class _SystemNavItem extends StatefulWidget {
  final String title;
  final String route;
  final VoidCallback? onClose;

  const _SystemNavItem({
    required this.title,
    required this.route,
    this.onClose,
  });

  @override
  State<_SystemNavItem> createState() => _SystemNavItemState();
}

class _SystemNavItemState extends State<_SystemNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        onTap: () {
          widget.onClose?.call();
          context.go(widget.route);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          // Slides right on interaction to fit the left-aligned format
          transform: Matrix4.translationValues(_isHovered ? 6.0 : 0.0, 0, 0),
          child: Text(
            widget.title,
            style: AppTextStyles.body.copyWith(
              fontSize: 16, 
              fontWeight: FontWeight.w800,
              letterSpacing: 2.5, // Wide tracking
              color: _isHovered ? AppColors.accent : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
