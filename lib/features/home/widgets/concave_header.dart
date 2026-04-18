import 'package:flutter/material.dart';

class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Start higher to make the curve deeper but smooth

    // Create a smooth, more noticeable U-shape (concave) bezier curve to the bottom right
    path.quadraticBezierTo(
      size.width / 2, size.height + 40, // Control point pushed down further to emphasize the curve
      size.width, size.height - 40, // End at the same elevated height
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ConcaveHeader extends StatelessWidget {
  final Widget child;
  final double height;
  final Decoration? decoration;

  const ConcaveHeader({
    super.key,
    required this.child,
    required this.height,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ConcaveClipper(),
      child: Container(
        height: height,
        decoration: decoration ?? const BoxDecoration(color: Color(0xFF11161D)),
        child: child,
      ),
    );
  }
}
