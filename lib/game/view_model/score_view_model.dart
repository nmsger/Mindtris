
import 'package:flutter/material.dart';

import '../../main.dart';
import '../model/score.dart';
import '../repository/score_repository.dart';

class ScoreViewModel extends ChangeNotifier {

  late final ScoreRepository _scoreRepository;

  ScoreViewModel({ScoreRepository? scoreRepository})
    : _scoreRepository = scoreRepository ?? getIt.get<ScoreRepository>() {
    _scoreRepository.addListener(_onScoreChanges);
  }

  Map<ScoreType, int> get scores => _scoreRepository.scores;

  int get totalScore => _scoreRepository.totalScore;

  _onScoreChanges() {
    notifyListeners();
  }

}