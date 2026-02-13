import 'package:flutter/material.dart';

/// The Board class stores required information 
/// about a tic-tac-toe board and contains
/// methods to modify this information. 
class Board {
  /// the board is represented as
  /// 
  /// [0, 1, 2]
  /// 
  /// [3, 4, 5]
  /// 
  /// [6, 7, 8]
  late List<int> boardAsList;
  late List<int> _rowSums;
  late List<int> _colSums;
  /// diagSums[0] is the left-right diagonal,
  /// 
  /// diagSums[1] is the right-left diagonal
  late List<int> _diagSums; 
  /// player 1 is X, player -1 is O. 
  /// 
  /// X always starts first 
  late int _player; 
  late int _numFreeSquares; 

  late int winner; 
  late bool gameOver;

  late String storableState;

  Board() {
    setBoard();
  } 

  void setBoard() {
    boardAsList = [for (int i=0; i<9; i++) 0];
    _rowSums = [0, 0, 0];
    _colSums = [0, 0, 0];
    
    _diagSums = [0, 0]; 
    /// player 1 is X, player -1 is O. 
    /// 
    /// X always starts first 
    _player = 1; 
    _numFreeSquares = 9; 

    winner = 0; 
    gameOver = false; 

    storableState = "";
  }

  /// Checks if anybody has won the game
  /// 
  /// 1 if X wins, -1 if O wins, 0 otherwise
  int _checkWinCondition() {
    if (winner != 0) return winner; 

    for (int i=0; i<3; i++) {
      if (_colSums[i] == 3 || _rowSums[i] == 3) {return 1;}
      if (_colSums[i] == -3 || _rowSums[i] == -3) {return -1;}
      if (i < 2) {
        if (_diagSums[i] == 3) {return 1;}
        if (_diagSums[i] == -3) {return -1;}
      }
    }
    return 0;
  }

  void _updateSums(int square) {
    int row = square ~/ 3; 
    int col = square % 3;
    _colSums[col] += _player;
    _rowSums[row] += _player; 

    if (row == col) {_diagSums[0] += _player;}
    if (row + col == 2) {_diagSums[1] += _player;}
  }

  /// Update the state of the board by playing
  /// the apppropriate move at the square. Square
  /// should be a number between 0 and 8, it is the
  /// square where the move will be played. Does nothing if
  /// the square is already occupied or if game is won.
  /// 
  /// This function updates ALL the information inside this board,
  /// including checking the winner. 
  void updateBoardState(int square) {
    if (boardAsList[square] != 0) return;
    if (winner != 0) return;

    boardAsList[square] = _player;
    _numFreeSquares -= 1; 
    _updateSums(square);
    storableState += square.toString();
    winner = _checkWinCondition();
    if (winner != 0 || _numFreeSquares == 0) gameOver = true; 
    _player = -_player; 
  }

  @override
  String toString() => storableState;
}

/// Stores an internal [Board] and allows some external
/// modification to be done to it 
class BoardModel extends ChangeNotifier {
  final Board _board = Board();

  /// 1 if X wins, -1 if O wins, 0 otherwise
  int winner() => _board.winner;
  bool isGameOver() => _board.gameOver; 

  /// ### UPDATES THE STATE OF THE BOARD
  /// 
  /// Update the state of the board by playing
  /// the apppropriate move at the square. Square
  /// should be a number between 0 and 8, it is the
  /// square where the move will be played. Does nothing if
  /// the square is already occupied or if game is won.
  /// 
  /// This function updates ALL the information inside this board,
  /// including checking the winner. 
  void updateState(int square) {
    _board.updateBoardState(square);
    notifyListeners();
  }

  /// returns the state of a given square, where square
  /// is an integer between 0 and 8. Return 0 for an empty
  /// square, 1 for an X and -1 for an O
  int getSquareState(int square) {
    return _board.boardAsList[square];
  }

  void reset() {
    _board.setBoard();
    notifyListeners();
  }

  /// Converts the stringState stored by shared_preferences
  /// into a board. The stored string must be a sequence of 
  /// squares, e.g. "0345", that determines the order in which
  /// moves were played. A board is constructed from this information.
  void setFromState(String? storedState) {
    if (storedState == null) return;

    for (int i=0; i<storedState.length; i++) {
      updateState(int.parse(storedState[i]));
    }
  }

  String getWinnerString() {
    if (winner() == 1) return "X wins!";
    if (winner() == -1) return "O wins!";
    if (isGameOver()) return "Draw!";
    return "";
  }

  @override
  /// Turns the board model into a string so that its
  /// state can be stored 
  String toString() => _board.toString();
}
