import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:slice_game/gameLoop.dart';

class GameOver{
  final GameLoop game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  GameOver(this.game){

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 65,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;
    painter.text = TextSpan(
      text: " ",
      style: textStyle,
    );
    painter.layout();
    

  }

  void update(double t){
    
}

  void render(Canvas c){
    painter.text = TextSpan(
      text: "GAME OVER",
      style: textStyle,
    );

    

    position = Offset(
      //if i want to center the score on the screen
      (game.screenSize.width / 2) - (painter.width / 2),
      //(game.screenSize.width) - (game.screenSize.width / 3),
      (game.screenSize.height / 2) - (painter.height / 2),
    );
    painter.paint(c, position);
  }

}