

import 'shape.dart';
import 'shape_color.dart';

final List<Shape> allShapes = [
  Shape(
      type: ShapeType.A,
      color: ShapeColor.violet,
      blocks: [Point(0, 1), Point(1, 1), Point(2, 1), Point(0, 0), Point(1, 2)]
  ),
  Shape(
    type: ShapeType.B,
    color: ShapeColor.orange,
    blocks: [Point(0, 0), Point(1, 0), Point(1, 1), Point(2, 1)],
  ),
  Shape(
    type: ShapeType.L,
    color: ShapeColor.pink,
    blocks: [Point(0, 1), Point(1, 1), Point(2, 1), Point(1, 0), Point(1, 2)],
  ),
  Shape(
    type: ShapeType.C,
    color: ShapeColor.blue,
    blocks: [Point(0, 1), Point(1, 1), Point(2, 1), Point(1, 0), Point(1, 2)],
  ),
  Shape(
    type: ShapeType.D,
    color: ShapeColor.black,
    blocks: [Point(0, 0), Point(0, 1), Point(0, 2), Point(0, 3), Point(1, 3), Point(2, 3), Point(3, 3)],
  ),
  Shape(
    type: ShapeType.E,
    color: ShapeColor.violet,
    blocks: [Point(0,0), Point(0, 1), Point(1, 1), Point(2, 1), Point(3, 1), Point(3, 0)],
  ),
];