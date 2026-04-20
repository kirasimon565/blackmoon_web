import 'package:flutter/material.dart';

class SimpleRosePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6FA3C8).withAlpha((0.6 * 255).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw a simple geometric mark that feels like a rose
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer circle
    canvas.drawCircle(center, radius, paint);

    // Inner diamond
    final path = Path()
      ..moveTo(center.dx, center.dy - radius * 0.7)
      ..lineTo(center.dx + radius * 0.7, center.dy)
      ..lineTo(center.dx, center.dy + radius * 0.7)
      ..lineTo(center.dx - radius * 0.7, center.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
