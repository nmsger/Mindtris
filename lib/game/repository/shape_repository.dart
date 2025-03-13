
import 'dart:math';

import 'package:mindtris/game/model/shape_color.dart';

import '../model/shape.dart';
import '../model/shapes.dart';

class ShapeRepository {
  final List<Shape> _shapes;
  late List<ShapeSelection> _currentTurn;
  final int randomSelectionSize = 5;

  ShapeRepository({List<Shape>? shapes})
      : _shapes = shapes ?? List.from(allShapes) {
    init();
  }

  List<ShapeSelection> get selection => List.unmodifiable(_currentTurn);

  void init() {
    assert(_shapes.length >= randomSelectionSize);

    _currentTurn = [];
    for (var i=0; i<randomSelectionSize; i++) {
      List<ShapeColor> avlColors = [ShapeColor.orange, ShapeColor.blue, ShapeColor.pink, ShapeColor.violet];
      avlColors.shuffle();
      Shape shape = _shapes[i].withColor(avlColors[0]);

      ShapeSelection selection = ShapeSelection(
          shape: shape,
          availableColors: avlColors)
      ;
      _currentTurn.add(selection);
    }
  }

  void updateShape(Shape shape) {
    final int index = _currentTurn.indexWhere((s) => s.shape.type == shape.type);
    ShapeSelection oldShape = _currentTurn[index];
    ShapeSelection newShape = ShapeSelection(shape: shape, availableColors: oldShape.availableColors);

    _currentTurn[index] = newShape;
  }

}