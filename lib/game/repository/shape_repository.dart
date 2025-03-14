
import 'dart:math';

import 'package:flutter/material.dart';

import '../model/shape.dart';
import '../model/shape_color.dart';
import '../model/shapes.dart';

class ShapeRepository extends ChangeNotifier {
  final List<Shape> _shapes;
  late List<ShapeSelection> _currentTurn;
  final int randomSelectionSize = 5;
  int curIndex = 0;
  List<ShapeColor> allColors = [ShapeColor.orange, ShapeColor.blue, ShapeColor.pink, ShapeColor.violet, ShapeColor.green];
  final Shape baseShape = Shape(type: ShapeType.X,
    color: ShapeColor.disabled,
    blocks: [Point(0, 0), Point(0, 1)]);

  ShapeRepository({List<Shape>? shapes})
    : _shapes = shapes ?? List.from(allShapes) {
    _init();
  }

  List<ShapeSelection> get selection => List.unmodifiable(_currentTurn);

  void updateShape(Shape shape) {
    final int index = _currentTurn.indexWhere((s) => s.shape.type == shape.type);
    ShapeSelection oldShape = _currentTurn[index];
    ShapeSelection newShape = ShapeSelection(shape: shape, availableColors: oldShape.availableColors);

    _currentTurn[index] = newShape;
  }

  bool nextTurn() {
    if (curIndex == _shapes.length) {
      _currentTurn = _disableAll();
      notifyListeners();
      return true;
    }
    _currentTurn = _generateSelections(
      randomSelectionSize,
      (i) => i == 0 ? _shapes[curIndex] : _currentTurn[i-1].shape,
    );

    curIndex++;
    return false;
  }

  List<ShapeSelection> _disableAll() {
    List<ShapeSelection> selection = [];
    for (var s in _currentTurn) {
      ShapeSelection newShape = ShapeSelection(
          shape: s.shape.withColor(ShapeColor.disabled),
          availableColors: []
      );
      selection.add(newShape);
    }
    return selection;
  }

  void _init() {
    assert(_shapes.length >= randomSelectionSize+1);
    // _shapes.removeLast();
    // _shapes.shuffle();
    _currentTurn = _generateSelections(
      randomSelectionSize,
      (i) => _shapes[i],
    );

    curIndex = randomSelectionSize;
  }

  List<ShapeSelection> _generateSelections(
    int count,
    Shape Function(int index) shapeProvider,
  ) {
    final Random random = Random();
    final List<int> weightedChoices = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 4];
    List<ShapeColor> availableColors = List.from(allColors);
    weightedChoices.shuffle();

    List<ShapeSelection> selections = [];
    for (var i = 0; i < count; i++) {
      // generate a random number of colors for each shape (0-4)
      // each color is unique and can only be assigned to one shape
      List<ShapeColor> shapeColors = [];
      int numColors = weightedChoices[random.nextInt(weightedChoices.length)];
      availableColors.shuffle(random);
      for (int j = 0; j < numColors && availableColors.isNotEmpty; j++) {
        shapeColors.add(availableColors.removeAt(0));
      }

      // create selection from shape + availableColors
      Shape currentShape = shapeProvider(i);
      Shape shape = shapeColors.isNotEmpty
        ? currentShape.withColor(shapeColors[0])
        : currentShape.withColor(ShapeColor.disabled);

      ShapeSelection selection = ShapeSelection(
        shape: shape,
        availableColors: shapeColors,
      );

      selections.add(selection);
    }
    // 2-block base shape gets remaining colors or all colors (if no remaining exist)
    Shape shape = availableColors.isNotEmpty
      ? baseShape.withColor(availableColors[0])
      : baseShape.withColor(allColors[0]);

    ShapeSelection selection = ShapeSelection(
      shape: shape,
      availableColors: availableColors.isNotEmpty 
        ? availableColors
        : List.from(allColors)
    );
    selections.add(selection);
    return selections;
  }

}
