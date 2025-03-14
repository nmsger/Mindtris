
import 'package:flutter/material.dart';

enum ShapeColor { orange, violet, pink, blue, black, green, empty, disabled }

extension ShapeColorExtension on ShapeColor {
  Color toColor() {
    switch (this) {
      case ShapeColor.orange:
        return Colors.orange;
      case ShapeColor.violet:
        return Colors.deepPurple;
      case ShapeColor.pink:
        return Colors.purpleAccent;
      case ShapeColor.blue:
        return Colors.cyan;
      case ShapeColor.black:
        return Colors.black;
      case ShapeColor.empty:
        return Colors.transparent;
      case ShapeColor.disabled:
        return Colors.grey;
      case ShapeColor.green:
        return Colors.green;
    }
  }
}