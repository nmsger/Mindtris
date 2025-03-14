
import 'package:flutter/material.dart';


import '../model/shape.dart';
import '../model/shape_color.dart';

class AbilityViewModel extends ChangeNotifier {

  int abilityCount = 1;

  bool get isDisabled => abilityCount == 0;


  onShapePlacement(Shape shape) {
    if (shape.color == ShapeColor.green) {
      abilityCount++;
    } else if (shape.color == ShapeColor.black) {
      abilityCount--;
    }
    notifyListeners();
  }
}