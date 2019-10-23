import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:slice_game/gameLoop.dart';
import 'package:flame/components/text_box_component.dart';

//this is an option to display the current color the player should attempt to hit
class Goal{
  final GameLoop game;
  Rect goalBorderRect;
  Paint goalBorderPaint;
  Rect goalRect;
  Paint goalPaint;
  TextPainter goalTextPainter;
  TextStyle goalTextStyle;
  Offset goalTextPosition;
  Color theGoalColor;
  

  Goal(this.game){
    //circle = 
    goalTextPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );

    goalTextStyle = TextStyle(
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

    goalTextPosition = Offset.zero;

    goalTextPainter.text = TextSpan(
      text: "Target Colour",
      style: goalTextStyle,
    );

    goalTextPainter.layout();

    goalTextPosition = Offset(
      //if i want to center the score on the screen
      (game.screenSize.width / 2) - (goalTextPainter.width / 2),
      //(game.screenSize.width) - (game.screenSize.width / 3),
      50,
    );

    goalBorderRect = Rect.fromLTWH((game.screenSize.width / 2) - (goalTextPainter.width / 2) + 30, 70, game.tileSize - 10, game.tileSize - 10);
    goalBorderPaint = Paint();
    goalBorderPaint.color = Color(0xffffffff);
    goalRect = Rect.fromLTWH((game.screenSize.width / 2) - (goalTextPainter.width / 2) + 35, 75, game.tileSize - 20, game.tileSize - 20);
    goalPaint = Paint();
    goalPaint.color = Color(0xff6ab04c);
    
  }

  void changeColour(Color newColour) {
    theGoalColor = newColour;
    goalPaint.color = newColour;
  }

  update(double t){
    //goalPaint.color = chosenColour;
  }

  render(Canvas c){
    goalTextPainter.paint(c, goalTextPosition);
    c.drawRect(goalBorderRect, goalBorderPaint);
    c.drawRect(goalRect, goalPaint);
  }

}