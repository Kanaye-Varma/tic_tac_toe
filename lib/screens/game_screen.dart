import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/game_board.dart';
import 'package:tic_tac_toe/logic/game_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatelessWidget {
  final BoardModel board = BoardModel(); 

  void setBoard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedState = prefs.getString("storedState");
    board.setFromState(storedState);
  }

  void storeBoardState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("storedState", board.toString());
  }

  GameScreen({super.key}) {
    setBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double gridSize = (constraints.maxHeight < constraints.maxWidth ?
                            constraints.maxHeight : constraints.maxWidth) / 1.4;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListenableBuilder(
                  listenable: board,
                  builder: (context, child) {
                    return Text(
                      board.getWinnerString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  },
                ),
                GameBoard(
                  board: board,
                  height: gridSize,
                  width: gridSize,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: board.reset,
                    child: Text("Reset game")
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      storeBoardState();
                      Navigator.pop(context);
                    },
                    child: Text("Save and exit")
                  ),
                ), 
              ]
            ),
          );
        },
      ),
    );
  }
}