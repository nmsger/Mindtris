
import 'package:flutter/material.dart';

import '../config/constants.dart';
import 'model/shape.dart';
import 'view_model/board_view_model.dart';
import 'view_model/score_view_model.dart';
import 'view_model/shape_selection_view_model.dart';
import 'widget/board_widget.dart';
import 'widget/score_widget.dart';
import 'widget/shape_selection_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();

}

class _GameScreenState extends State<GameScreen> {
  final double cellSize = BoardCfg.boardCellSize;
  final BoardViewModel boardViewModel = BoardViewModel();
  final ScoreViewModel scoreViewModel = ScoreViewModel();
  final ShapeSelectionViewModel selectionViewModel = ShapeSelectionViewModel();

  void onPlacedShape() {
    selectionViewModel.nextTurn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mindtris"),
      ),
      body: Center(
        child: Column(
          children: [
            ScoreWidget(viewModel: scoreViewModel,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: BoardWidget(viewModel: boardViewModel, onPlacedShape: (Shape shape, Point point) => onPlacedShape(), ),
            ),
            ShapeSelectionWidget(viewModel: selectionViewModel,),
          ],
        ),
      )
    );
  }

}
