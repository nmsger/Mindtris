
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'config/constants.dart';
import 'game/game_screen.dart';
import 'game/repository/board_repository.dart';
import 'game/repository/score_repository.dart';


final getIt = GetIt.instance;

void setup() {
  BoardRepository boardRepository = BoardRepository(
      boardSize: BoardCfg.boardSize,
      cellSize: BoardCfg.boardCellSize
  );
  getIt.registerSingleton(boardRepository);
  ScoreRepository scoreRepository = ScoreRepository();
  getIt.registerSingleton<ScoreRepository>(scoreRepository);
}

void main() {
  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mindtris",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
      debugShowCheckedModeBanner: true,
    );
  }}