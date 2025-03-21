

import 'package:flutter/material.dart';

import '../../main.dart';
import '../model/score.dart';
import '../model/shape.dart';
import '../model/shape_color.dart';
import 'board_repository.dart';

class ScoreRepository extends ChangeNotifier {
  final Map<ScoreType, int> _scores;
  late final BoardRepository _boardRepository;

  ScoreRepository({BoardRepository? boardRepository})
    : _boardRepository = boardRepository ?? getIt.get<BoardRepository>(),
    _scores = {for (var type in ScoreType.values) type: 0} {
    _boardRepository.addListener(_updateScore);
    // run _updateScore once to calculate negative scores
    _updateScore();
  }

  Map<ScoreType, int> get scores => Map.unmodifiable(_scores);

  int get totalScore => _scores.values.fold(0, (sum, score) => sum + score);

  void reset() {
    for (var type in ScoreType.values) {
      _scores[type] = 0;
    }
  }

  void _setScore(ScoreType type, int value) {
    _scores[type] = value;
  }

  void _updateScore() {
    _calculateOrange();
    _calculateViolet();
    _calculatePink();
    _calculateBlue();
    _calculateEmpty();
    _calculateSection();

    notifyListeners();
  }

  void _calculateOrange() {
    final List<int> scores = [0, 3, 6, 10, 15, 20];
    int totalOrange = _boardRepository.placedShapes
      .where((shape) => shape.shape.color == ShapeColor.orange).length;
    if (totalOrange >= scores.length) {
      totalOrange = scores.length - 1;
    }
    _setScore(ScoreType.orange, scores[totalOrange]);
  }

  void _calculateViolet() {
    final int scoreMultiplier = 2;
    int total = 0;
    List<PlacedShape> violetShapes = _boardRepository.placedShapes
      .where((s) => s.shape.color == ShapeColor.violet).toList();

    for (PlacedShape ps in violetShapes) {
      for (Point block in ps.shape.blocks) {
        Point gridPosition = _boardRepository.getGridPosition(block, ps.point);
        List<ShapeColor> adjColors = _boardRepository.getAdjacentCells(gridPosition);
        if (adjColors.contains(ShapeColor.orange)) {
          total++;
        }
      }
    }
    _setScore(ScoreType.violet, total*scoreMultiplier);
  }

  void _calculatePink() {
    int total = 0;
    List<PlacedShape> pinkShapes = _boardRepository.placedShapes
      .where((s) => s.shape.color == ShapeColor.pink).toList();
    for (PlacedShape pinkShape in pinkShapes) {
      // -1 to discount the shape itself
      int sameType = _boardRepository.placedShapes.where((s) => s.shape.type == pinkShape.shape.type).length - 1;
      total += sameType * pinkShape.shape.blocks.length;
    }
    _setScore(ScoreType.pink, total);
  }

  void _calculateBlue() {
    final List<int> scores = [-16, -12, -7, -3, 0];
    int countPerSection = 0;

    for (var section in _boardRepository.boardType.sections) {
      for (var s in section.gridCoordinates) {
        if (_boardRepository.boardGrid[s.y][s.x] == ShapeColor.blue) {
          countPerSection++;
          break;
        }
      }
    }

    if (countPerSection >= scores.length) {
      countPerSection = scores.length - 1;
    }
    _setScore(ScoreType.blue, scores[countPerSection]);
  }

  void _calculateSection() {
    final int scorePerSection = 10;
    int numberSections = 0;

    for (var section in _boardRepository.boardType.sections) {
      bool isFilled = true;
      for (var s in section.gridCoordinates) {
        if (_boardRepository.boardGrid[s.y][s.x] == ShapeColor.empty) {
          isFilled = false;
        }
      }
      if (isFilled) {
        numberSections++;
      }
    }

    _setScore(ScoreType.section, numberSections*scorePerSection);
  }

  void _calculateEmpty() {
    int maxEmpty = -1;
    for (var section in _boardRepository.boardType.sections) {
      int sectionEmpty = 0;
      for (var s in section.gridCoordinates) {
        if (_boardRepository.boardGrid[s.y][s.x] == ShapeColor.empty) {
          sectionEmpty++;
        }
      }

      if (maxEmpty < sectionEmpty) {
        maxEmpty = sectionEmpty;
      }
    }
    maxEmpty *= -1;
    _setScore(ScoreType.empty, maxEmpty);
  }
}
