import 'package:flutter/material.dart';


ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light, 
    primary: Colors.orange.shade500,
    onPrimary: Colors.black,
    secondary: Colors.black,
    onSecondary: Colors.black, 
    surface: Colors.orange.shade200,
    onSurface: Colors.black,
    error: Colors.red, 
    onError: Colors.red, 
  )
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark, 
    primary: Colors.orange.shade900,
    onPrimary: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.white, 
    surface: Color(0xFF4F3FA0),
    onSurface: Colors.white,
    error: Colors.red, 
    onError: Colors.red, 
  )
);

class ThemeInfo extends ChangeNotifier {
  ThemeData _theme = lightTheme;

  ThemeData getTheme() => _theme.copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _theme.colorScheme.primary, 
        foregroundColor: _theme.colorScheme.onPrimary
      )
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _theme.colorScheme.primary,
      foregroundColor: _theme.colorScheme.onPrimary,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: _theme.colorScheme.onSurface,
        fontWeight: FontWeight.bold
      ),
      headlineSmall: TextStyle(
        color: _theme.colorScheme.onPrimary,
        fontWeight: FontWeight.bold
      ),
      displayMedium: TextStyle(
        color: _theme.colorScheme.onPrimary,
      ),
    )
  ); 

  void changeTheme() {
    _theme = (_theme == lightTheme) ? darkTheme : lightTheme; 
    notifyListeners();
  }

  @override
  String toString() => _theme == lightTheme ? "light" : "dark";
}