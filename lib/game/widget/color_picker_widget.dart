
import 'package:flutter/material.dart';

import '../model/shape.dart';
import '../model/shape_color.dart';

class ColorPickerWidget extends StatelessWidget {
  final Shape shape;
  final List<ShapeColor> availableColors;
  final Function(ShapeColor) onColorSelected;

  const ColorPickerWidget({
    required this.shape,
    required this.availableColors,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: availableColors.map((color) {
        final isSelected = shape.color == color;
        return Padding(
          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
          child: GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color.toColor(),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                ],
              ),
            ),
          ),
        );
      }
      ).toList(),
    );
  }
}
