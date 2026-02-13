import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/themes.dart';
import 'package:tic_tac_toe/logic/name_change_logic.dart';

class SettingsScreen extends StatelessWidget {

  final ThemeInfo themeInfo;
  final UserNameModel userName;
  const SettingsScreen({super.key, required this.themeInfo, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.0,
          children: [
            ListenableBuilder(
              listenable: themeInfo,
              builder: (_, _) => ElevatedButton(
                onPressed: themeInfo.changeTheme,
                child: Text("Theme: ${themeInfo.toString()}")
              ),
            ),
            ElevatedButton(
              child: Text("Change user name"),
              onPressed: () async {
                String? name = await showDialog(
                  context: context, 
                  builder: (dialogcontext) => UserNameInputForm()
                );
                if (name == null) return;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("userName", name);
                userName.updateName(name);
              },
            )
          ],
        ),
      ),
    );
  }
}

