
import 'package:flutter/material.dart';
import 'package:mindtris/game/widget/ShapeWidget.dart';

import 'model/Shape.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();

}

class _GameScreenState extends State<GameScreen> {
  final double cellSize = 30.0;

  final List<Shape> shapes = [
    Shape(
      type: ShapeType.I,
      color: Colors.green,
      blocks: [Point(0, 1), Point(1, 1), Point(2, 1), Point(0, 0), Point(1, 2)]
    ),
    Shape(
        type: ShapeType.T,
        color: Colors.pink,
        blocks: [Point(0, 0), Point(1, 0), Point(1, 1), Point(2, 1)],
    ),
    Shape(
      type: ShapeType.T,
      color: Colors.cyan,
      blocks: [Point(0, 1), Point(1, 1), Point(2, 1), Point(1, 0), Point(1, 2)],
    ),
    Shape(
      type: ShapeType.T,
      color: Colors.brown,
      blocks: [Point(0, 0), Point(0, 1), Point(0, 2), Point(1, 2), Point(2, 2)],
    ),
    Shape(
      type: ShapeType.T,
      color: Colors.deepPurple,
      blocks: [Point(0,0), Point(0, 1), Point(1, 1), Point(2, 1), Point(3, 1), Point(3, 0)],
    ),
  ];

  void _handleShapeRotation(int index, Shape rotatedShape) {
    setState(() {
      shapes[index] = rotatedShape;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mindtris"),
      ),
      body: Column(
        children: [
         Container(
           height: 220,
           width: 400,
           color: Colors.grey[200],
           padding: const EdgeInsets.symmetric(vertical: 20),
           child: SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: List.generate(shapes.length, (index) {
                 return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                   child: Container(
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.black),
                     ),
                     child: SizedBox(
                       width: 140,
                       height: 140,
                       child: Center(
                         child: ShapeWidget(
                           shape: shapes[index],
                           cellSize: cellSize,
                           onRotate: (rotatedShape) => _handleShapeRotation(index, rotatedShape),
                         ),
                       ),
                     ),
                   ),
                 );
               }),
             )
           )
         )
        ],
      )
    );
  }

}