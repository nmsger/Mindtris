
import 'package:flutter/material.dart';
import 'package:mindtris/config/constants.dart';
import 'package:mindtris/game/view_model/score_view_model.dart';
import 'package:mindtris/game/view_model/shape_selection_view_model.dart';
import 'package:mindtris/game/widget/board_widget.dart';
import 'package:mindtris/game/widget/score_widget.dart';
import 'package:mindtris/game/widget/shape_selection_widget.dart';

import 'view_model/board_view_model.dart';

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

  // void _handleShapeRotation(int index, Shape rotatedShape) {
  //   setState(() {
  //       shapes[index] = rotatedShape;
  //     }
  //   );
  // }

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
              child: BoardWidget(viewModel: boardViewModel),
            ),
            ShapeSelectionWidget(viewModel: selectionViewModel,),
            // Container(
            //   height: 220,
            //   width: 400,
            //   color: Colors.grey[200],
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: List.generate(shapes.length, (index) {
            //           return Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.black),
            //               ),
            //               child: SizedBox(
            //                 width: 140,
            //                 height: 140,
            //                 child: Center(
            //                   child: DraggableShapeWidget(
            //                     shape: shapes[index],
            //                     cellSize: cellSize,
            //                     onRotate: (rotatedShape) => _handleShapeRotation(index, rotatedShape),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           );
            //         }
            //       ),
            //     )
            //   )
            // )
          ],
        ),
      )
    );
  }

}
