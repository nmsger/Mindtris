
import 'package:flutter/material.dart';
import 'package:mindtris/game/widget/shape_widget.dart';

import '../model/shape.dart';
import '../model/shape_color.dart';
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
            ),
            // ElevatedButton(onPressed: viewModel.nextTurn, child: Text("NEXT"))
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
              selection.shape.color != ShapeColor.disabled
                  ? _buildDraggable(selection.shape)
                  : _buildNonDraggable(selection.shape),

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

  Widget _buildNonDraggable(Shape shape) {
    return  Expanded(
      child: Center(
        child: ShapeWidget(
          shape: shape,
          cellSize: 20,
        ),
      ),
    );
  }

}
