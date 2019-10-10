import 'package:flutter/material.dart';

import './start_menu.dart';
import 'models/screen_states.dart';

void main() => runApp(SliceGame());

class SliceGame extends StatefulWidget {
  _SliceGameState createState() => _SliceGameState();
}

class _SliceGameState extends State<SliceGame> {
  static const String _title = "Slice Game";
  ScreenState _currentScreenState = ScreenState.startMenu;
  //temp --> 0 means main menu, 1 means start game, 2 means leaderboard and 3 is profile
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: _homeWidget(),
      ),
    );
  }

  Widget _homeWidget() {
    Widget homeWidget;
    if (_currentScreenState == ScreenState.startMenu)
      homeWidget = StartMenu(
        onHighScorePressed: () {
          setState(() {
            _currentScreenState = ScreenState.highScore;
          });
        },
        onPlayerProfilePressed: () {
          setState(() {
            _currentScreenState = ScreenState.playerProfile;
          });
        },
        onPlayPressed: () {
          setState(() {
            _currentScreenState = ScreenState.play;
          });
        },
      );
    else if(_currentScreenState == ScreenState.play) {
      homeWidget = Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Quit game"),
              onPressed: () {
                setState(() {
                  _currentScreenState =ScreenState.startMenu;
                });
              },
            ),
            Text("You are playing the game"),
          ],
        ),
      );
    } else if(_currentScreenState == ScreenState.highScore) {
      homeWidget =Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Back to Main Menu"),
              onPressed: () {
                setState(() {
                  _currentScreenState =ScreenState.startMenu;
                });
              },
            ),
            Text("You are view the High Scores"),
          ],
        ),
      );
    } else if(_currentScreenState == ScreenState.playerProfile) {
      homeWidget =Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Quit game"),
              onPressed: () {
                setState(() {
                  _currentScreenState =ScreenState.startMenu;
                });
              },
            ),
            Text("You are view your player profile"),
          ],
        ),
      );
    }
    return homeWidget;
  }
}
