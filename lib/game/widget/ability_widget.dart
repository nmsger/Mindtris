
import 'package:flutter/material.dart';


import '../model/shape.dart';
import '../model/shape_color.dart';
import '../view_model/ability_view_model.dart';
import 'draggable_shape_widget.dart';
import 'shape_widget.dart';

class AbilityWidget extends StatelessWidget {
  final AbilityViewModel viewModel;

  AbilityWidget({super.key, required this.viewModel});
  final Shape shape = Shape(type: ShapeType.Z, color: ShapeColor.black, blocks: [Point(0,0)]);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (BuildContext context, Widget? child) {
            return Row(
              children: [
                if (viewModel.isDisabled)
                  ShapeWidget(
                    shape: shape.withColor(ShapeColor.disabled),
                    cellSize: 20,
                  )
                else
                  DraggableShapeWidget(
                      shape: shape,
                      cellSize: 20,
                      onRotate: (_) => (),
                      feedbackCellSize: 40,
                      onMirror: (_) => ()
                  ),

                const SizedBox(width: 16),

                Text("${viewModel.abilityCount}x",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    )
                ),
              ],
            );
          },

        ),
      ),
    );
  }

}
