import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slice_game/pages/home_page.dart';
//import 'package:flutter/gestures.dart';
import 'package:flame/util.dart';
// import 'package:Flame/util/addGestureRecognizer.dart';
// import 'package:slice_game/pages/play_page.dart';
// import 'package:slice_game/gameLoop.dart';


void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  
    // PanGestureRecognizer drag = PanGestureRecognizer();
    // drag.onUpdate = game.handleDragUpdate;
    // flameUtil.addGestureRecognizer(drag);
  
  runApp(SliceGame());
  
  
} 


class SliceGame extends StatelessWidget {
  static const String _title = "Chroma-Slash";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: _title),
    );
  }
}
