
import 'package:flutter/material.dart';

import '../../main.dart';
import '../model/board.dart';
import '../model/shape.dart';
import '../repository/board_repository.dart';

class BoardViewModel extends ChangeNotifier {
  ShapePreview? preview;
  late BoardRepository boardRepository;
  Function(Shape shape, Point point)? onPlacedShape;

  BoardViewModel({
    BoardRepository? boardRepository}) {
    this.boardRepository = boardRepository ?? getIt.get<BoardRepository>();
  }

  int get boardSize => boardRepository.boardSize;
  double get cellSize => boardRepository.cellSize;
  List<Section> get boardSections => boardRepository.boardType.sections;

  void onDragAcceptWithDetails(DragTargetDetails<Shape> details) {
    if (preview == null) {
      return;
    }
    bool placed = boardRepository.placeShape(preview!.shape, preview!.point);

    if (onPlacedShape != null && placed) {
      onPlacedShape!(preview!.shape, preview!.point);
    }

    notifyListeners();
    _resetPreview();
  }

  void onDragLeave() {
    _resetPreview();
    notifyListeners();
  }

  onDragMove(BuildContext context, DragTargetDetails<Shape> details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final gridPosition = box.localToGlobal(Offset(0, 0));
    final relativeOffset = details.offset - gridPosition;

    final int rawGridX = (relativeOffset.dx / cellSize).floor();
    final int rawGridY = (relativeOffset.dy / cellSize).floor();
    final Point gridPoint = Point(rawGridX, rawGridY);

    _resetPreview();
    if (boardRepository.isWithinGrid(gridPoint)) {
      preview = ShapePreview(shape: details.data, point: gridPoint);
    }
    notifyListeners();
  }

  bool canPlaceShape() {
    if (preview == null) {
      return false;
    }
    return boardRepository.canPlaceShape(preview!.shape, preview!.point);
  }

  List<PlacedShape> getPlacedShapes() => boardRepository.placedShapes;

  void _resetPreview() {
    preview = null;
  }
}
