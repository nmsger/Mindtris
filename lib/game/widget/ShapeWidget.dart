

import 'package:flutter/material.dart';

import '../model/Shape.dart';

class ShapeWidget extends StatelessWidget {
  final Shape shape;
  final double cellSize;
  final double opacity;
  final bool isValid;
  final Function(Shape) onRotate;

  const ShapeWidget({
    super.key,
    required this.shape,
    required this.cellSize,
    this.opacity = 1.0,
    this.isValid = true,
    required this.onRotate,
  });

  @override
  Widget build(BuildContext context) {
    int maxX = 0;
    int maxY = 0;

    for (var block in shape.blocks) {
      if (block.x > maxX) maxX = block.x;
      if (block.y > maxY) maxY = block.y;
    }

    return GestureDetector(
      onTap: _handleTap,
      child:  Container(
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
      ),
    );
  }

  void _handleTap() {
    onRotate(shape.rotate());
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
              ? shape.color
              : Colors.red.withOpacity(0.7),
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