
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mindtris/game/repository/board_repository.dart';

import 'game/game_screen.dart';


final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton(BoardRepository());
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