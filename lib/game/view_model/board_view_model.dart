
import 'package:flutter/material.dart';

import '../../main.dart';
import '../model/shape.dart';
import '../repository/board_repository.dart';

class BoardViewModel extends ChangeNotifier {
  final int boardSize;
  final double cellSize;
  ShapePreview? preview;
  late BoardRepository boardRepository;

  BoardViewModel({
    required this.boardSize,
    required this.cellSize,
    BoardRepository? boardRepository}) {
    this.boardRepository = boardRepository ?? getIt.get<BoardRepository>();
  }

  void onDragAcceptWithDetails(DragTargetDetails<Shape> details) {
    if (preview == null) {
      return;
    }
    boardRepository.placeShape(preview!.shape, preview!.point);
    _resetPreview();
    notifyListeners();
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

    _resetPreview();
    if (rawGridX >= 0 && rawGridX < boardSize && rawGridY >= 0 && rawGridY < boardSize) {
      preview = ShapePreview(shape: details.data, point: Point(rawGridX, rawGridY));
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
