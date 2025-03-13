
import 'package:flutter/material.dart';
import 'package:mindtris/game/model/shape_color.dart';

import '../model/shape.dart';
import '../view_model/shape_selection_view_model.dart';
import 'color_picker_widget.dart';
import 'draggable_shape_widget.dart';

class ShapeSelectionWidget extends StatelessWidget {
  final ShapeSelectionViewModel viewModel;

  const ShapeSelectionWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, Widget? child) {
        return Wrap(
          children: [
            ...viewModel.selection.map((s) =>
              _buildShapeContainer(s)
            )
          ],
        );
      },
    );
  }

  Widget _buildShapeContainer(ShapeSelection selection) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: SizedBox(
          width: 120,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDraggable(selection.shape),
              ColorPickerWidget(
                shape: selection.shape,
                availableColors: selection.availableColors,
                onColorSelected: (color) => viewModel.onColorSelected(selection.shape, color),
              )
              // _buildColorPicker(selection.availableColors),
            ],
          )
        )
      ),
    );
  }

  Widget _buildDraggable(Shape shape) {
    return  Expanded(
      child: Center(
        child: DraggableShapeWidget(
          shape: shape,
          cellSize: 20,
          feedbackCellSize: 40,
          onRotate: (rotatedShape) => (viewModel.onRotatedShape(rotatedShape)),
        ),
      ),
    );
  }

  Widget _buildColorPicker(List<ShapeColor> availableColors) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Wrap(
          // mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 1),
            ...availableColors.expand((c) => [
                _buildColorTouchable(c),
                const SizedBox(width: 8),
              ]),
          ],
        ),
      ),
    );
  }

  Widget _buildColorTouchable(ShapeColor color) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: color.toColor(),
        shape: BoxShape.circle,
      ),
    );
  }
}
