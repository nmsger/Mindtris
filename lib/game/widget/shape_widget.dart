

import 'package:flutter/material.dart';
import 'package:mindtris/game/model/shape_color.dart';

import '../model/shape.dart';

class ShapeWidget extends StatelessWidget {
  final Shape shape;
  final double cellSize;
  final double opacity;
  final bool isValid;

  const ShapeWidget({
    super.key,
    required this.shape,
    required this.cellSize,
    this.opacity = 1.0,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    int maxX = 0;
    int maxY = 0;

    for (var block in shape.blocks) {
      if (block.x > maxX) maxX = block.x;
      if (block.y > maxY) maxY = block.y;
    }

    return Container(
      decoration: BoxDecoration(
        // transparent border necessary to increase GestureDetector range
        border: Border.all(color: Colors.transparent),
      ),
      child: Opacity(
        opacity: opacity,
        child: SizedBox(
          width: (maxX + 1) * cellSize,
          height: (maxY + 1) * cellSize,
          child: Center(
            child: Stack(
              children: shape.blocks
                  .map((block) => _buildShapeBlock(block))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShapeBlock(Point block) {
    return Positioned(
      left: block.x * cellSize,
      top: block.y * cellSize,
      child: Container(
        width: cellSize,
        height: cellSize,
        decoration: BoxDecoration(
          color: isValid
              ? shape.color.toColor()
              : Colors.red.withValues(alpha: 0.7),
          border: Border.all(
            color: isValid
                ? Colors.white
                : Colors.red.shade900,
            width: 1,
          ),
        ),
      ),
    );
  }
}