

import 'package:flutter/material.dart';
import 'package:mindtris/game/model/shape_color.dart';

import '../model/shape.dart';
import 'shape_widget.dart';

class DraggableShapeWidget extends StatelessWidget {
  final Shape shape;
  final double cellSize;
  final double feedbackCellSize;
  final bool isValid;
  final Function(Shape) onRotate;
  final Function(Shape) onMirror;

  const DraggableShapeWidget({
    super.key,
    required this.shape,
    required this.cellSize,
    this.isValid = true,
    required this.onRotate,
    required this.feedbackCellSize, required this.onMirror,
  });

  void _handleTap() {
    onRotate(shape.rotate());
  }

  void _handleDoubleTap() {
    onMirror(shape.mirror());
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
      feedback: ShapeWidget(shape: shape, cellSize: feedbackCellSize, opacity: 0.7),
      dragAnchorStrategy: (Draggable<Object> draggable, BuildContext context, Offset position) => Offset(25, 25),
      childWhenDragging: ShapeWidget(shape: shape, cellSize: cellSize, opacity: 0.3),
      child: GestureDetector(
          onTap: _handleTap,
          onDoubleTap: _handleDoubleTap,
          child:  ShapeWidget(shape: shape, cellSize: cellSize, opacity: 1.0),
      ),
    );
  }
}