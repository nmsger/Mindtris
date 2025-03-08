
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double cellSize;

  GridPainter({required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 0.5;

    // Draw vertical lines
    for (int i = 0; i <= size.width / cellSize; i++) {
      canvas.drawLine(
          Offset(i * cellSize, 0),
          Offset(i * cellSize, size.height),
          paint
      );
    }

    // Draw horizontal lines
    for (int i = 0; i <= size.height / cellSize; i++) {
      canvas.drawLine(
          Offset(0, i * cellSize),
          Offset(size.width, i * cellSize),
          paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
