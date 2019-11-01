import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:slice_game/gameLoop.dart';

class ScoreCount{
  final GameLoop game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  TextPainter livesPainter;
  TextStyle livesTextStyle;
  Offset livesPosition;

  ScoreCount(this.game){

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
      text: "Score",
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      //if i want to center the score on the screen
      10,
      //(game.screenSize.width) - (game.screenSize.width / 3),
      50,
    );

  }

  void update(double t){
    if ((livesPainter.text?.text ?? '') != game.score.toString()) {
      livesPainter.text = TextSpan(
      text: game.score.toString(),
      style: livesTextStyle,
    );

    livesPainter.layout();

    livesPosition = Offset(
      //if i want to center the score on the screen
      25,
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