# 🎮 Tic Tac Toe (Flutter Web)

A responsive Tic Tac Toe game built with Flutter and deployed to GitHub Pages.

This project was created as a focused exercise to practice intermediate level Flutter
concepts. 

🔗 Live Demo: https://kanaye-varma.github.io/tic_tac_toe/

## Features 

- 3×3 interactive game board
- X always starts first
- Automatic turn switching
- Win and draw detection
- Game over state handling
- Light / Dark theme toggle
- Player name persistence using shared_preferences
- Responsive layout (web-friendly)

## Architecture

This project follows a lightweight MVVM-inspired structure:
```
lib/
 ├── logic/
 │     ├── game_logic.dart
 │
 ├── screens/
 │     ├── home_screen.dart
 │     ├── game_screen.dart
 │     ├── settings_screen.dart
 │
 ├── widgets/
 │     ├── game_board.dart
 │
 ├── themes.dart
 └── main.dart
```
## Key Design Decisions

- `Board`: Pure game logic and win detection
- `BoardModel`: `ChangeNotifier`-based state management
- `GameBoard`: Stateless UI that reacts to model changes
- `ThemeInfo`: Centralized theme control
- Single source of truth for game state

## Concepts Practiced

Building this project involved hands-on experience with:

- State management using `ChangeNotifier`
- Reactive UI with `ListenableBuilder`
- Separation of concerns (UI vs domain logic)
- Incremental win detection using row/column/diagonal sums
- Theme switching using `ThemeData`
- Simple persistence via `shared_preferences`
- Navigation using `Navigator`
