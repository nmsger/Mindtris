
import '../model/shape.dart';

class BoardRepository {
  final List<PlacedShape> placedShapes = [];

  bool canPlaceShape(Shape shape, Point point) {
    return true;
  }

  void placeShape(Shape shape, Point point) {
    if (!canPlaceShape(shape, point)) {
      return;
    }

    placedShapes.add(PlacedShape(
        shape: shape.copyWith(),
        point: point
      ));    
  }
}
