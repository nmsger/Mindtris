
import 'package:flutter/material.dart';
import '../model/shape.dart';

class BoardViewModel extends ChangeNotifier {
  final int boardSize;
  final double cellSize;
  int? hoverX;
  int? hoverY;
  Shape? hoverShape;

  Offset? initialDragOffset;
  Offset? initialDragPosition;

  final List<PlacedShape> placedShapes = [];

  BoardViewModel({required this.boardSize, required this.cellSize});

  void onDragAcceptWithDetails(DragTargetDetails<Shape> details) {
    if (hoverX == null || hoverY == null) {
      return;
    }
    placedShapes.add(PlacedShape(
        shape: hoverShape!.copyWith(),
        x: hoverX!,
        y: hoverY!
    ));
    hoverY = null;
    hoverX = null;
    hoverShape = null;
    notifyListeners();
  }

  void onDragLeave() {
    hoverY = null;
    hoverX = null;
    hoverShape = null;
    notifyListeners();
  }

  onDragMove(BuildContext context, DragTargetDetails<Shape> details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final gridPosition = box.localToGlobal(Offset(0, 0));
    final relativeOffset = details.offset - gridPosition;

    // No adjustment to the dragAnchor here - we'll handle that in the grid calculation

    // Calculate grid position, taking into account the cell size and potentially the shape's dimensions
    final int rawGridX = (relativeOffset.dx / cellSize).floor();
    final int rawGridY = (relativeOffset.dy / cellSize).floor();


    print("$rawGridX, $rawGridY");

    if (rawGridX >= 0 && rawGridX < boardSize && rawGridY >= 0 && rawGridY < boardSize) {
        hoverShape = details.data;
        hoverX = rawGridX;
        hoverY = rawGridY;

    }
    else {
        hoverShape = null;
        hoverX = null;
        hoverY = null;

    }
    notifyListeners();
  }
}