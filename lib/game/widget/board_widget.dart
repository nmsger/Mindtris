

import 'package:flutter/material.dart';

import '../model/shape.dart';
import '../painter/grid_painter.dart';
import '../view_model/board_view_model.dart';
import 'shape_widget.dart';

class BoardWidget extends StatelessWidget {
  final BoardViewModel viewModel;

  const BoardWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            _drawGrid(),
            // draw placedShapes
            ...viewModel.getPlacedShapes().map((shape) => Positioned(
                left: shape.point.x * viewModel.cellSize,
                top: shape.point.y * viewModel.cellSize,
                child: ShapeWidget(shape: shape.shape, cellSize: viewModel.cellSize,)
            )
            ),
            // draw shape preview
            if (viewModel.preview != null)
              _drawPreviewShape(),
            _drawDragTargetArea(),
          ],
        );
      },
    );
  }

  Widget _drawGrid() {
    return  Container(
      width: viewModel.boardSize * viewModel.cellSize,
      height: viewModel.boardSize * viewModel.cellSize,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.black.withValues(alpha: 0.1),
      ),
      child: CustomPaint(
        painter: GridPainter(cellSize: viewModel.cellSize, sections: viewModel.boardSections),
      ),
    );
  }

  Widget _drawDragTargetArea() {
    return  Positioned(
      width: viewModel.boardSize * viewModel.cellSize,
      height: viewModel.boardSize * viewModel.cellSize,
      child: Builder(
        builder: (context) => DragTarget<Shape>(
          builder: (_, candidateData, rejectedData) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            );
          },
          onAcceptWithDetails: (details) =>
          viewModel.onDragAcceptWithDetails(details),
          onLeave: (_) => viewModel.onDragLeave(),
          onMove: (details) => viewModel.onDragMove(context, details),
        ),
      )
    );
  }

  Widget _drawPreviewShape() {
    return  Positioned(
      left: viewModel.preview!.point.x * viewModel.cellSize,
      top: viewModel.preview!.point.y * viewModel.cellSize,
      child: ShapeWidget(
        shape: viewModel.preview!.shape,
        cellSize: viewModel.cellSize,
        isValid: viewModel.canPlaceShape(),
        opacity: 0.6,
      ),
    );
  }

}
