// Logo custom painter to match the shapes in the LedgeCRM logo (intersecting rectangles/squares)
import 'package:flutter/material.dart';

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()..color = Colors.white;
    // Left shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * 0.4, size.height * 0.7),
        const Radius.circular(2),
      ),
      paint1,
    );
    // Right shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.5,
          size.height * 0.3,
          size.width * 0.5,
          size.height * 0.7,
        ),
        const Radius.circular(2),
      ),
      paint1,
    );
    // Overlap shape
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.3,
          size.height * 0.4,
          size.width * 0.4,
          size.height * 0.2,
        ),
        const Radius.circular(2),
      ),
      paint1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}