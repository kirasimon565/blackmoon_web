import 'package:flutter/material.dart';

class BlackRosePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    final Paint paint = Paint()
      ..color = const Color(0xFF6FA3C8).withAlpha((0.6 * 255).toInt())
      ..style = PaintingStyle.fill;

    // Layer 1: Base Core
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.55), size.width * 0.15, paint);

    // Layer 2: Petal Blocks
    Path petal1 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.1, size.height * 0.2, size.width * 0.4, size.height * 0.1)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.3, size.width * 0.4, size.height * 0.5)
      ..close();
    canvas.drawPath(petal1, paint);

    Path petal2 = Path()
      ..moveTo(size.width * 0.8, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.9, size.height * 0.9, size.width * 0.6, size.height * 0.9)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.7, size.width * 0.6, size.height * 0.5)
      ..close();
    canvas.drawPath(petal2, paint);

    Path petal3 = Path()
      ..moveTo(size.width * 0.6, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.9, size.height * 0.1, size.width * 0.8, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width * 0.6, size.height * 0.3)
      ..close();
    canvas.drawPath(petal3, paint);

    // Layer 3: Interruption Cut
    final Paint erasePaint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;

    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.8),
      Offset(size.width * 0.9, size.height * 0.2),
      erasePaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
