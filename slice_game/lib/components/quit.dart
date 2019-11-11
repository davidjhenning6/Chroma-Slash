import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:slice_game/gameLoop.dart';
//import 'package:flame/components/text_box_component.dart';

//this is an option to display the current color the player should attempt to hit
class Quit {
  final GameLoop game;
  Rect quitBorderRect;
  Paint quitBorderPaint;

  TextPainter quitPainter;
  TextStyle quitTextStyle;
  Offset quitPosition;

  Quit(this.game) {
    quitBorderRect =
        Rect.fromLTWH(90, 10, game.tileSize - 30, game.tileSize - 30);
    quitBorderPaint = Paint();
    quitBorderPaint.color = Color(0xffffffff);

    quitPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    quitTextStyle = TextStyle(
      color: Color(0xff000000),
      fontSize: 40,
    );

    quitPainter.text = TextSpan(
      text: "X",
      style: quitTextStyle,
    );

    quitPainter.layout();
    quitPosition = Offset(
      //if i want to center the score on the screen
      92,
      //(game.screenSize.width) - (game.screenSize.width / 3),
      3,
    );
  }

  update(double t) {
    //goalPaint.color = chosenColour;
  }

  render(Canvas c) {
    c.drawRect(quitBorderRect, quitBorderPaint);
    quitPainter.paint(c, quitPosition);
  }

  void onTapDown({@required BuildContext context}) {
    Navigator.pop(context);
  }
}
