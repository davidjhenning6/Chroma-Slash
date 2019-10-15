import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slice_game/pages/home_page.dart';
//import 'package:flutter/gestures.dart';
import 'package:flame/util.dart';
//import 'package:slice_game/pages/play_page.dart';
//import 'package:slice_game/gameLoop.dart';


void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  
  //GameInit g = new GameInit();

  runApp(SliceGame());

  // TapGestureRecognizer tapper = TapGestureRecognizer();
  // tapper.onTapDown = game.onTapDown;
  // flameUtil.addGestureRecognizer(tapper);
} 


class SliceGame extends StatelessWidget {
  static const String _title = "Slice Game";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: _title),
    );
  }
}
