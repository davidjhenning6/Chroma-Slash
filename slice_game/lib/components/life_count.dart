import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:slice_game/gameLoop.dart';

class LifeCount{
  final GameLoop game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  TextPainter livesPainter;
  TextStyle livesTextStyle;
  Offset livesPosition;

  LifeCount(this.game){

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );

    livesPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 20,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    livesTextStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 20,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );
    position = Offset.zero;
    livesPosition = Offset.zero;

    painter.text = TextSpan(
      text: "Lives",
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      //if i want to center the score on the screen
      (game.screenSize.width / 2) - (painter.width / 2) + 140,
      //(game.screenSize.width) - (game.screenSize.width / 3),
      50,
    );

  }

  void update(double t){
    if ((livesPainter.text?.text ?? '') != game.lives.toString()) {
      livesPainter.text = TextSpan(
      text: game.lives.toString(),
      style: livesTextStyle,
    );

    livesPainter.layout();

    livesPosition = Offset(
      //if i want to center the score on the screen
      (game.screenSize.width / 2) - (painter.width / 2) + 140,
      //(game.screenSize.width) - (game.screenSize.width / 3),
      70,
    );
  }
    
  }

  void render(Canvas c){
    painter.paint(c, position);
    livesPainter.paint(c, livesPosition);
  }

}