
import 'package:flutter/material.dart';

import '../model/board.dart';
import '../model/shape.dart';
import '../model/shape_color.dart';


class BoardRepository extends ChangeNotifier {
  final int boardSize;
  final double cellSize;
  late final List<List<ShapeColor>> _boardGrid;
  final List<PlacedShape> _placedShapes = [];
  final BoardType boardType = boardTypes[0];

  BoardRepository({
    required this.boardSize,
    required this.cellSize,
  }) {
    _init();
  }

  void _init() {
    _boardGrid = List.generate(
      boardSize,
      (_) => List.generate(boardSize, (_) => ShapeColor.empty));
    for (var placedShape in boardType.distractorShapes) {
      placeShape(placedShape.shape, placedShape.point);
    }
  }

  List<PlacedShape> get placedShapes => List.unmodifiable(_placedShapes);
  List<List<ShapeColor>> get boardGrid => List.unmodifiable(_boardGrid);

  bool isWithinGrid(Point point) {
    return point.x >= 0 && point.x < boardSize
      && point.y >= 0 && point.y < boardSize;
  }

  bool _isCellOccupied(Point point) {
    return _boardGrid[point.y][point.x] != ShapeColor.empty;
  }

  Point getGridPosition(Point shapePos, Point anchorPoint) {
    int x = shapePos.x + anchorPoint.x;
    int y = shapePos.y + anchorPoint.y;
    return Point(x, y);
  }

  List<ShapeColor> getAdjacentCells(Point point) {
    final directions = [
      (-1, 0),  // up
      (0, 1),   // right
      (1, 0),   // down
      (0, -1),  // left
    ];
    List<ShapeColor> results = [];
    for (var (dy, dx) in directions) {
      Point gridPosition = Point(point.x + dx, point.y + dy);
      if (!isWithinGrid(gridPosition)) {
        continue;
      }
      results.add(_boardGrid[gridPosition.y][gridPosition.x]);
    }
    return results;
  }

  bool canPlaceShape(Shape shape, Point anchorPoint) {
    bool hasAdjacentNeighbor = false;
    for (Point block in shape.blocks) {
      Point gridPosition = getGridPosition(block, anchorPoint);

      if (!isWithinGrid(gridPosition)) {
        return false;
      }
      if(_isCellOccupied(gridPosition)) {
        return false;
      }

      List<ShapeColor> adjacentColors = getAdjacentCells(gridPosition);
      if (adjacentColors.contains(shape.color)) {
        return false;
      }

      if (_placedShapes.isNotEmpty &&
        adjacentColors.any((color) => color != ShapeColor.empty && color != ShapeColor.disabled)) {
        hasAdjacentNeighbor = true;
      }
    }
    if (_placedShapes.length >= boardType.distractorShapes.length+1 && !hasAdjacentNeighbor) {
      return false;
    }
    return true;
  }

  bool placeShape(Shape shape, Point anchorPoint) {
    if (!canPlaceShape(shape, anchorPoint)) {
      return false;
    }

    for (Point block in shape.blocks) {
      Point gridPosition = getGridPosition(block, anchorPoint);
      _boardGrid[gridPosition.y][gridPosition.x] = shape.color;
    }

    _placedShapes.add(PlacedShape(
        shape: shape.copyWith(),
        point: anchorPoint
      ));
    notifyListeners();
    return true;
  }
}
