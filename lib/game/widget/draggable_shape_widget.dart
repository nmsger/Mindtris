

import 'package:flutter/material.dart';
import 'package:mindtris/game/model/shape_color.dart';

import '../model/shape.dart';
import 'shape_widget.dart';

class DraggableShapeWidget extends StatelessWidget {
  final Shape shape;
  final double cellSize;
  final bool isValid;
  final Function(Shape) onRotate;

  const DraggableShapeWidget({
    super.key,
    required this.shape,
    required this.cellSize,
    this.isValid = true,
    required this.onRotate,
  });

  void _handleTap() {
    print("_handleTap");
    onRotate(shape.rotate());
  }

  @override
  Widget build(BuildContext context) {
    int maxX = 0;
    int maxY = 0;

    for (var block in shape.blocks) {
      if (block.x > maxX) maxX = block.x;
      if (block.y > maxY) maxY = block.y;
    }

    return Draggable<Shape>(
      data: shape,
      feedback: ShapeWidget(shape: shape, cellSize: cellSize, opacity: 0.7),
      dragAnchorStrategy: (Draggable<Object> draggable, BuildContext context, Offset position) => Offset(50, 50),
      // dragAnchorStrategy: pointerDragAnchorStrategy,
      childWhenDragging: ShapeWidget(shape: shape, cellSize: cellSize, opacity: 0.3),
      child: GestureDetector(
          onTap: _handleTap,
          child:  ShapeWidget(shape: shape, cellSize: cellSize, opacity: 1.0),
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