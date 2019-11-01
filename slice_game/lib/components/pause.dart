import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:slice_game/gameLoop.dart';
import 'package:flame/components/text_box_component.dart';

//this is an option to display the current color the player should attempt to hit
class Pause{
  final GameLoop game;
  Rect pauseBorderRect;
  Paint pauseBorderPaint;

  Rect pauseLeftRect;
  Paint pauseLeftPaint;
  Rect pauseRightRect;
  Paint pauseRightPaint;

  Pause(this.game){
    //circle = 

    pauseBorderRect = Rect.fromLTWH(10, 10, game.tileSize - 30, game.tileSize - 30);
    pauseBorderPaint = Paint();
    pauseBorderPaint.color = Color(0xffffffff);

    pauseLeftRect = Rect.fromLTWH(18, 12, 5, game.tileSize - 35);
    pauseLeftPaint = Paint();
    pauseLeftPaint.color = Color(0xff000000);

    pauseRightRect = Rect.fromLTWH(30, 12, 5, game.tileSize - 35);
    pauseRightPaint = Paint();
    pauseRightPaint.color = Color(0xff000000);
    
  }



  update(double t){
    //goalPaint.color = chosenColour;
    if(game.isGameOver) {
      pauseBorderPaint.color = Color(0xff949494);
    }
  }

  render(Canvas c){
    c.drawRect(pauseBorderRect, pauseBorderPaint);
    c.drawRect(pauseLeftRect, pauseLeftPaint);
    c.drawRect(pauseRightRect, pauseRightPaint);
  }

  void onTapDown() {
    if(game.isGameOver) {
      
    } else {
      if(game.isPaused) {
        game.isPaused = false;
      } else {
        game.isPaused = true;
      }
    }
    
    //game.initialize();
    // game.spawnFly();
  }

}