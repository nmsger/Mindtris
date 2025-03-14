
import 'package:flutter/material.dart';
import 'package:mindtris/game/model/shape_color.dart';
import 'package:mindtris/game/view_model/ability_view_model.dart';

import '../config/constants.dart';
import 'model/shape.dart';
import 'view_model/board_view_model.dart';
import 'view_model/score_view_model.dart';
import 'view_model/shape_selection_view_model.dart';
import 'widget/ability_widget.dart';
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
  final AbilityViewModel abilityViewModel = AbilityViewModel();
  bool gameEnd = false;

  // ToDo - Refactor to decouple logic from UI
  void onPlacedShape(Shape shape) {
    abilityViewModel.onShapePlacement(shape);
    if (shape.color != ShapeColor.black) {
      selectionViewModel.nextTurn();
    }
    if (selectionViewModel.gameEnd) {
      setState(() {
          gameEnd = true;
        }
      );
    }
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  AbilityWidget(viewModel: abilityViewModel,),
                  Spacer(),
                  ScoreWidget(viewModel: scoreViewModel, dismissible: !gameEnd,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: BoardWidget(viewModel: boardViewModel, onPlacedShape: (Shape shape, Point point) => onPlacedShape(shape), ),
            ),
            ShapeSelectionWidget(viewModel: selectionViewModel,),
          ],
        ),
      )
    );
  }

}
