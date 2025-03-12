
import 'shape.dart';

class Section {
  final Point anchor;
  final int width, height;
  final List<Point> gridCoordinates;

  Section({
    required this.anchor,
    required this.width,
    required this.height,
  }) : gridCoordinates = _init(anchor, width, height);

  static List<Point> _init(Point anchor, int width, int height) {
    List<Point> coordinates = [];
    for (int y = anchor.y; y < anchor.y + height; y++) {
      for (int x = anchor.x; x < anchor.x + width; x++) {
        coordinates.add(Point(x, y));
      }
    }
    return coordinates;
  }
  @override
  String toString() {
    return "Section<$anchor W$width H$height $gridCoordinates";
  }
}

class BoardType {
  final List<Section> sections;

  BoardType({required this.sections});
}

final List<BoardType> boardTypes = [
  BoardType(sections: [
      Section(anchor: Point(0, 0), width: 3, height: 6),
      Section(anchor: Point(3, 0), width: 6, height: 3),
      Section(anchor: Point(0, 6), width: 6, height: 3),
      Section(anchor: Point(3, 3), width: 3, height: 3),
      Section(anchor: Point(6, 3), width: 3, height: 6),
    ])
];
