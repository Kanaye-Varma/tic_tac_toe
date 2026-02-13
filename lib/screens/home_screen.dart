import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/screens/settings_screen.dart';
import 'package:tic_tac_toe/themes.dart';
import 'package:tic_tac_toe/logic/name_change_logic.dart';

class HomeScreen extends StatelessWidget {
  final ThemeInfo themeInfo;

  final UserNameModel userName = UserNameModel(); 

  void setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("userName");
    if (name != null) userName.updateName(name);
  }

  HomeScreen({super.key, required this.themeInfo}) {
    setName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListenableBuilder(
          listenable: userName, 
          builder: (_, _) => Text("Welcome, ${userName.name}")
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.0,
          children: [
            Text(
              "LET'S PLAY TIC-TAC-TOE",
              style: Theme.of(context).textTheme.headlineMedium
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GameScreen()
                ));
              },
              child: Text("Play game")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    themeInfo: themeInfo,
                    userName: userName,
                  )
                ));
              }, 
              child: Text("Settings")
            )
          ],
        ),
      ),
    );
  }
}