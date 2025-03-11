
import 'package:flutter/material.dart';

import '../model/board.dart';
import '../model/shape.dart';


class BoardRepository {
  final int boardSize;
  final double cellSize;
  final List<List<Color>> boardGrid;
  final List<PlacedShape> placedShapes = [];
  final BoardType boardType = boardTypes[0];

  BoardRepository({
    required this.boardSize,
    required this.cellSize,
  }) : boardGrid = List.generate(
      boardSize,
          (_) => List.generate(boardSize, (_) => Colors.transparent)
  );

  bool isWithinGrid(Point point) {
    return point.x >= 0 && point.x < boardSize
        && point.y >= 0 && point.y < boardSize;
  }

  bool _isCellOccupied(Point point) {
    return boardGrid[point.y][point.x] != Colors.transparent;
  }

  Point _getGridPosition(Point shapePos, Point anchorPoint) {
    int x = shapePos.x + anchorPoint.x;
    int y = shapePos.y + anchorPoint.y;
    return Point(x, y);
  }

  List<Color> _getAdjacentCells(Point point) {
    final directions = [
      (-1, 0),  // up
      (0, 1),   // right
      (1, 0),   // down
      (0, -1),  // left
    ];
    List<Color> results = [];
    for (var (dy, dx) in directions) {
      Point gridPosition = Point(point.x + dx, point.y + dy);
      if (!isWithinGrid(gridPosition)) {
        continue;
      }
      results.add(boardGrid[gridPosition.y][gridPosition.x]);
    }
    return results;
  }

  bool canPlaceShape(Shape shape, Point anchorPoint) {
    bool hasAdjacentNeighbor = false;
    for (Point block in shape.blocks) {
      Point gridPosition = _getGridPosition(block, anchorPoint);

      if (!isWithinGrid(gridPosition)) {
        return false;
      }
      if(_isCellOccupied(gridPosition)) {
        return false;
      }

      List<Color> adjacentColors = _getAdjacentCells(gridPosition);
      if (adjacentColors.contains(shape.color)) {
        return false;
      }

      if (placedShapes.isNotEmpty &&
        adjacentColors.any((color) => color != Colors.transparent)) {
        hasAdjacentNeighbor = true;
      }
    }
    if (placedShapes.isNotEmpty && !hasAdjacentNeighbor) {
      return false;
    }
    return true;
  }

  void placeShape(Shape shape, Point anchorPoint) {
    if (!canPlaceShape(shape, anchorPoint)) {
      return;
    }

    for (Point block in shape.blocks) {
      Point gridPosition = _getGridPosition(block, anchorPoint);
      boardGrid[gridPosition.y][gridPosition.x] = shape.color;
    }

    placedShapes.add(PlacedShape(
        shape: shape.copyWith(),
        point: anchorPoint
      ));    
  }
}
