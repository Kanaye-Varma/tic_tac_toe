import 'package:flutter/material.dart';
import 'package:tic_tac_toe/logic/game_logic.dart';

/// DEBUG
// void main() => runApp(TestApp());
// double _min(double a, double b) => a < b ? a : b;

class BoardTile extends StatelessWidget {
  final double height;
  final double width; 
  final int state; 
  const BoardTile({
    super.key,
    required this.state, 
    required this.height, 
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: BoxBorder.all(color: Colors.black, width: 2.0)
      ),
      child: state == 0 ? null : FittedBox(
        child: Text(
          state == 1 ? "X" : "O",
          style: Theme.of(context).textTheme.headlineSmall,
        )
      )
    );
  }
}


class GameBoard extends StatelessWidget {

  final BoardModel board;
  final double height; 
  final double width;

  const GameBoard({
    super.key, 
    required this.board, 
    required this.height, 
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: board,
      builder: (context, child) {
        return SizedBox(
          height: height,
          width: width,
          child: GridView.extent(
            maxCrossAxisExtent: width/3,
            childAspectRatio: width/height,
            children: [
              for (int sq=0; sq<9; sq++)
                GestureDetector(
                  onTap: board.isGameOver() ? null : () {
                    board.updateState(sq);
                  },
                  child: BoardTile(
                    state: board.getSquareState(sq),
                    height: height/3, 
                    width: width/3
                  ),
                )
            ]
          ),
        );
      }
    );
  }
}

// ------------------------------------------------

/// DEBUG
/*
class TestApp extends StatelessWidget {
  
  final BoardModel board = BoardModel();

  TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Debugging game board"),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double gridSize = _min(constraints.maxHeight, constraints.maxWidth);
            return Center(
              child: GameBoard(
                board: board,
                height: gridSize / 1.5,
                width: gridSize / 1.5
              ),
            );
          }
        ),
      )
    );
  }
}
*/