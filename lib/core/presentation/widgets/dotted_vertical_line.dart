import 'package:flutter/material.dart';

class DottedVerticalLinePainter extends CustomPainter {
  final double dashHeight;
  final double dashSpace;
  final double strokeWidth;
  final Color dashColor;
  const DottedVerticalLinePainter({
    this.dashHeight = 2.5, // 3 - 2.5
    this.dashSpace = 2.5,
    this.strokeWidth = 2.5,
    this.dashColor = const Color(0xff246BFD),
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0;
    final paint = Paint()
      ..color = dashColor
      ..strokeWidth = strokeWidth;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
