
import 'dart:math';

import 'package:mindtris/game/model/shape_color.dart';

enum ShapeType { A, B, C, D, E, F, G, H, I, J, K, L, M }

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Point &&
              runtimeType == other.runtimeType &&
              x == other.x &&
              y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return "Point<$x, $y>";
  }
}

class Shape {
  final ShapeType type;
  final ShapeColor color;
  final List<Point> blocks;

  Shape({required this.type, required this.color, required this.blocks});

  Shape withColor(ShapeColor newColor) {
    return Shape(
      type: type,
      color: newColor,
      blocks: List.from(blocks),
    );
  }

  Shape copyWith() {
    return Shape(
      type: type,
      color: color,
      blocks: List.from(blocks),
    );
  }

  Shape rotate() {
    int minY = blocks.map((b) => b.y).reduce(min);
    int maxY = blocks.map((b) => b.y).reduce(max);
    int height = maxY - minY;

    // 90 degree rotation
    List<Point> rotatedNormalizedBlocks = blocks.map((b) =>
        Point(height - b.y, b.x)
    ).toList();

    return Shape(
      type: type,
      color: color,
      blocks: rotatedNormalizedBlocks,
    );
  }

  @override
  String toString() {
    return "Shape<$type, $color>";
  }
}

class ShapePreview {
  final Shape shape;
  final Point point;

  ShapePreview({required this.shape, required this.point});

  @override
  String toString() {
    return "ShapePreview<$shape $point";
  }
}

class PlacedShape {
  final Shape shape;
  final Point point;

  PlacedShape({required this.shape, required this.point});

  @override
  String toString() {
    return "PlacedShape<${shape.type} $point>";
  }
}

class ShapeSelection {
  final Shape shape;
  final List<ShapeColor> availableColors;

  ShapeSelection({required this.shape, required this.availableColors});

  ShapeSelection copyWith() {
    return ShapeSelection(shape: shape.copyWith(), availableColors: List.from(availableColors));
  }
}