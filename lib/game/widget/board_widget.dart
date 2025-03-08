

import 'package:flutter/material.dart';

import '../model/shape.dart';
import 'shape_widget.dart';

class BoardWidget extends StatefulWidget {

  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  final int gridWidth = 9;
  final int gridHeight = 9;
  final double cellSize = 30.0;
  int? hoverX;
  int? hoverY;
  Shape? hoverShape;

  Offset? initialDragOffset;
  Offset? initialDragPosition;

  final List<PlacedShape> placedShapes = [PlacedShape(
      shape: Shape(
        type: ShapeType.I,
        color: Colors.green,
        blocks: [Point(0, 1), Point(1, 1), Point(2, 1), Point(0, 0), Point(1, 2)]
      ),
      x: 0,
      y: 0),
    PlacedShape(shape: Shape(
        type: ShapeType.T,
        color: Colors.pink,
        blocks: [Point(0, 0), Point(1, 0), Point(1, 1), Point(2, 1)],
      ), x: 2, y: 0)
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _drawGrid(),
        // draw placedShapes
        ...placedShapes.map((shape) => Positioned(
            left: shape.x * cellSize,
            top: shape.y * cellSize,
            child: ShapeWidget(shape: shape.shape, cellSize: cellSize)
          )
        ),
        if (hoverShape != null && hoverX != null && hoverY != null)
          Positioned(
            left: hoverX! * cellSize,
            top: hoverY! * cellSize,
            child: ShapeWidget(
              shape: hoverShape!,
              cellSize: cellSize,
              opacity: 0.6,
            ),
          ),
        _drawDragTargetArea(),
      ],
    );
  }

  Widget _drawGrid() {
    return  Container(
      width: gridWidth * cellSize,
      height: gridHeight * cellSize,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.black.withValues(alpha: 0.1),
      ),
      child: CustomPaint(
        painter: GridPainter(cellSize: cellSize),
      ),
    );
  }

  Widget _drawDragTargetArea() {
    return  Positioned(
      width: gridWidth * cellSize,
      height: gridHeight * cellSize,
      child: DragTarget<Shape>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          );
        },
        onAcceptWithDetails: (details) {
          if (hoverX != null && hoverY != null) {
            setState(() {
              placeShape(details.data, hoverX!, hoverY!);
              hoverShape = null;
              hoverX = null;
              hoverY = null;
            }
            );
          }
        },
        onLeave: (_) {
          setState(() {
            hoverShape = null;
            hoverX = null;
            hoverY = null;
          }
          );
        },
        onMove: (details) {
          print("onMove");
          final RenderBox box = context.findRenderObject() as RenderBox;
          final gridPosition = box.localToGlobal(Offset(0, 0));
          final relativeOffset = details.offset - gridPosition;

          // No adjustment to the dragAnchor here - we'll handle that in the grid calculation

          // Calculate grid position, taking into account the cell size and potentially the shape's dimensions
          final int rawGridX = (relativeOffset.dx / cellSize).floor();
          final int rawGridY = (relativeOffset.dy / cellSize).floor();


          print("$rawGridX, $rawGridY");

          if (rawGridX >= 0 && rawGridX < gridWidth && rawGridY >= 0 && rawGridY < gridHeight) {
            setState(() {
              hoverShape = details.data;
              hoverX = rawGridX;
              hoverY = rawGridY;
            });
          }
          else {
            setState(() {
              hoverShape = null;
              hoverX = null;
              hoverY = null;
            });
          }
        },
      ),
    );
  }

  void placeShape(Shape shape, int gridX, int gridY) {
    // Mark cells as occupied
    // Add to placed shapes
    placedShapes.add(PlacedShape(
        shape: shape.copyWith(),
        x: gridX,
        y: gridY
    ));
  }
}

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
