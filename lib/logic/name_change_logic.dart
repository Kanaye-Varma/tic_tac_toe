import 'package:flutter/material.dart';

class UserNameModel extends ChangeNotifier {
  String name = "Player";

  void updateName(String newName) {
    name = newName; 
    notifyListeners();
  }
}

class UserNameInputForm extends StatefulWidget {
  const UserNameInputForm({super.key});

  @override
  State<UserNameInputForm> createState() => _UserNameInputFormState();
}

class _UserNameInputFormState extends State<UserNameInputForm> {

  final _key = GlobalKey<FormState>();
  String userName = "Player"; 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      constraints: BoxConstraints(
        maxHeight: 400, maxWidth: 400,
                        minWidth: 200
      ),
      content: Form(
        key: _key, 
        child: Column(
          children: [
            TextFormField(
              initialValue: "Player",
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "Enter your name"
              ),
              validator: (value) => (value == null || value == "") ? 
                                    "Please enter a valid name" : null,
              onChanged: (value) {
                userName = value; 
              }
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Navigator.of(context).pop(userName);
                  }
                  else {
                    Navigator.pop(context, "Player");
                  }
                },
                child: Text("Okay")),
            )
          ],
        )
      ),
    );
  }
}