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

          // Invisible overlay to close the menu when clicking outside of it
          if (_isMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: closeMenu,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  color: Colors.black.withAlpha(120), // Subtle dimming effect
                ),
              ),
            ),

          // 🔥 SYSTEM CONCAVE MENU (emerges from right edge, flat)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            // Slides down from 60 to 85 when opened
            top: _isMenuOpen ? 85.0 : 60.0, 
            right: 0.0, // Anchored to the right edge, not floating
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              // Fades in and out
              opacity: _isMenuOpen ? 1.0 : 0.0, 
              child: IgnorePointer(
                ignoring: !_isMenuOpen, // Prevents clicks when closed/invisible
                child: const _FloatingMenuPanel(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// THE SYSTEM PANEL DESIGN with CONCAVE NOTCH
// ==========================================
class _FloatingMenuPanel extends StatelessWidget {
  // Constants for the panel's visual geometry
  static const double _width = 200.0;
  static const double _notchXOffsetFromRight = 40.0; // Visual alignment to menu icon
  static const double _notchWidth = 20.0;
  static const double _notchDepth = 10.0;

  const _FloatingMenuPanel();

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _MenuPanelClipper(
        notchXOffsetFromRight: _notchXOffsetFromRight,
        notchWidth: _notchWidth,
        notchDepth: _notchDepth,
      ),
      child: Container(
        width: _width,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: BoxDecoration(
          // Using solid AppColors background for the panel, attached to edge
          color: AppColors.backgroundSecondary.withAlpha(255), 
          // Sharp edges on the corner, clipping handles the notch
          borderRadius: BorderRadius.zero, 
          // No shadow, no glow, flat look.
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Text aligned left for a controlled system readout feel
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            _MinimalNavItem(title: "HOME", route: "/", onClose: (context.findAncestorStateOfType<MainScaffoldState>())?.closeMenu),
            const SizedBox(height: 28), // Increased spacing for breathing room
            _MinimalNavItem(title: "DREADMOOR", route: "/dreadmoor", onClose: (context.findAncestorStateOfType<MainScaffoldState>())?.closeMenu),
            const SizedBox(height: 28),
            _MinimalNavItem(title: "TRACKER", route: "/tracker", onClose: (context.findAncestorStateOfType<MainScaffoldState>())?.closeMenu),
            const SizedBox(height: 28),
            _MinimalNavItem(title: "CONTACT", route: "/contact", onClose: (context.findAncestorStateOfType<MainScaffoldState>())?.closeMenu),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// CUSTOM CLIPPER FOR THE CONCAVE NOTCH
// ==========================================
class _MenuPanelClipper extends CustomClipper<Path> {
  final double notchXOffsetFromRight;
  final double notchWidth;
  final double notchDepth;

  _MenuPanelClipper({
    required this.notchXOffsetFromRight,
    required this.notchWidth,
    required this.notchDepth,
  });

  @override
  Path getClip(Size size) {
    var path = Path();
    // Start at top right, attached to the edge
    path.moveTo(size.width, 0); 
    // Line to top left
    path.lineTo(0, 0); 
    // Line down left side
    path.lineTo(0, size.height); 

    // Calculate notch position near the right edge
    double notchCenterX = size.width - notchXOffsetFromRight;
    
    // Bottom edge with precise concave cut
    path.lineTo(notchCenterX - notchWidth / 2, size.height);
    // Inward concave U-cut (using quadraticBezierTo for a tight radius)
    path.quadraticBezierTo(notchCenterX, size.height - notchDepth, notchCenterX + notchWidth / 2, size.height);
    
    // Line to bottom right corner
    path.lineTo(size.width, size.height); 
    // Line up right side to close, attached to the edge
    path.lineTo(size.width, 0); 
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_MenuPanelClipper oldClipper) {
    return oldClipper.notchXOffsetFromRight != notchXOffsetFromRight ||
           oldClipper.notchWidth != notchWidth ||
           oldClipper.notchDepth != notchDepth;
  }
}

// ==========================================
// MINIMAL NAV ITEM INTERACTION
// ==========================================
class _MinimalNavItem extends StatefulWidget {
  final String title;
  final String route;
  final VoidCallback? onClose; // Updated for dynamic retrieval

  const _MinimalNavItem({
    required this.title,
    required this.route,
    this.onClose,
  });

  @override
  State<_MinimalNavItem> createState() => _MinimalNavItemState();
}

class _MinimalNavItemState extends State<_MinimalNavItem> {
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
          widget.onClose?.call(); // Close menu
          context.go(widget.route);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          // Slides slightly to the left on hover/tap since it's now left-aligned
          transform: Matrix4.translationValues(_isHovered ? -4.0 : 0.0, 0, 0),
          child: Text(
            widget.title,
            style: AppTextStyles.body.copyWith(
              fontSize: 16, 
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
              // Color changes on hover using AppColors.accent
              color: _isHovered ? AppColors.accent : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
