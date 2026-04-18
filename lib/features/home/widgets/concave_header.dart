import 'package:flutter/material.dart';

class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // Start at the bottom left

    // Create a subtle upward (inward) curve in the center
    path.quadraticBezierTo(
      size.width / 2, size.height - 40, // Control point pulls the bottom edge upwards by 40px
      size.width, size.height, // End at the bottom right
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
