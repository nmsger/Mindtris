
import 'package:flutter/material.dart';

import '../model/board.dart';

class GridPainter extends CustomPainter {
  final double cellSize;
  final List<Section> sections;

  GridPainter({required this.cellSize, required this.sections});

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

    Paint gridLineThick = Paint()
      ..color = Colors.black38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (Section section in sections) {
      double startX = section.anchor.x * cellSize;
      double startY = section.anchor.y * cellSize;
      double endX = (section.anchor.x + section.width) * cellSize;
      double endY = (section.anchor.y + section.height) * cellSize;

      canvas.drawLine(Offset(startX, startY), Offset(endX, startY), gridLineThick);
      canvas.drawLine(Offset(startX, endY), Offset(endX, endY), gridLineThick);

      // Draw left and right borders
      canvas.drawLine(Offset(startX, startY), Offset(startX, endY), gridLineThick);
      canvas.drawLine(Offset(endX, startY), Offset(endX, endY), gridLineThick);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
