import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flame/util.dart';
import 'package:slice_game/gameLoop.dart';

class PlayPage extends StatefulWidget {
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  // Util flameUtil = Util();
  void quitGame() {
    Navigator.pop(context);
  }

  

  
  @override
  Widget build(BuildContext context) {
    GameLoop game = new GameLoop(context);
    return game.widget;
    
  }
}
