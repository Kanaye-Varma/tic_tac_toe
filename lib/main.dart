import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/themes.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeInfo themeInfo = ThemeInfo();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeInfo,
      builder: (context, child) {
        return MaterialApp(
          title: "Tic Tac Toe",
          theme: themeInfo.getTheme(),
          home: HomeScreen(themeInfo: themeInfo)
        );
      }
    );
  }
}