import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  void quitGame() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: <Widget>[
            Text("Currently Playing a Game"),
            RaisedButton(
              child: Text("Quit Game"),
              onPressed: quitGame,
            ),
          ],
        ),
      ),
    );
  }
}
