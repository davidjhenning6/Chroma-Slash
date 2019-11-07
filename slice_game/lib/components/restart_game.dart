import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:slice_game/gameLoop.dart';
import 'package:flame/components/text_box_component.dart';

//this is an option to display the current color the player should attempt to hit
class RestartGame{
  final GameLoop game;
  Rect restartBorderRect;
  Paint restartBorderPaint;

  TextPainter restartPainter;
  TextStyle restartTextStyle;
  Offset restartPosition;


  RestartGame(this.game){

    restartBorderRect = Rect.fromLTWH(50, 10, game.tileSize - 30, game.tileSize - 30);
    restartBorderPaint = Paint();
    restartBorderPaint.color = Color(0xffffffff);

    restartPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );

    restartTextStyle = TextStyle(
      color: Color(0xff000000),
      fontSize: 40,
    );

    restartPainter.text = TextSpan(
      text: "R",
      style: restartTextStyle,
    );

    restartPainter.layout();
    restartPosition = Offset(
      //if i want to center the score on the screen
      52,
      //(game.screenSize.width) - (game.screenSize.width / 3),
      3,
    );
    
  }



  update(double t){
    //goalPaint.color = chosenColour;
  }

  render(Canvas c){
    c.drawRect(restartBorderRect, restartBorderPaint);
    restartPainter.paint(c, restartPosition);
  }

  void onTapDown() {
    game.initialize();
  }

}