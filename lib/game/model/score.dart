
enum ScoreType {goal, section, orange, violet, pink, blue, empty}

// class ScoreTracker {
//   final Map<ScoreType, int> scores;
//
//   ScoreTracker() : scores = Map.fromIterable(
//     ScoreType.values,
//     value: (_) => 0,
//   );
//
//   void setScore(ScoreType type, int value) {
//     scores[type] = value;
//   }
//
//   int getScore(ScoreType type) {
//     return scores[type];
//   }
// }