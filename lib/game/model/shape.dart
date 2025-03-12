
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mindtris/game/model/shape_color.dart';

enum ShapeType { I, O, T, L }

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
    return "($x, $y)";
  }
}

class Shape {
  final ShapeType type;
  final ShapeColor color;
  final List<Point> blocks;

  Shape({required this.type, required this.color, required this.blocks});

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