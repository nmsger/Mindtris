

import 'package:flutter/material.dart';

import '../../main.dart';
import '../model/shape.dart';
import '../model/shape_color.dart';
import '../repository/shape_repository.dart';

class ShapeSelectionViewModel extends ChangeNotifier {
  final double cellSize = 40;
  final double feedbackCellSize = 20;
  late final ShapeRepository _shapeRepository;

  ShapeSelectionViewModel({
  ShapeRepository? shapeRepository}) :
        _shapeRepository = shapeRepository ?? getIt.get<ShapeRepository>();

  List<ShapeSelection> get selection => _shapeRepository.selection;

  void onRotatedShape(Shape shape) {
    _shapeRepository.updateShape(shape);
    notifyListeners();
  }

  void onColorSelected(Shape shape, ShapeColor color) {
    Shape newShape = shape.withColor(color);
    _shapeRepository.updateShape(newShape);
    notifyListeners();
  }
}
