import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:slice_game/gameLoop.dart';
//import 'package:slice_game/pages/home_page.dart';
import 'package:flame/util.dart';

class PlayPage extends StatefulWidget {
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {



  void quitGame() {
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    GameLoop game = new GameLoop(context);
    // Util flameUtil = Util();
    // PanGestureRecognizer drag = PanGestureRecognizer();
    // drag.onUpdate = game.handleDragUpdate;
    // flameUtil.addGestureRecognizer(drag);
    return game.widget;
  }
}



