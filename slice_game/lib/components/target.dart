import 'dart:ui';
import 'package:slice_game/gameLoop.dart';

class Target{
  final GameLoop game;
  Rect tarRect;
  Paint tarPaint;
  bool isHit = false;
  bool isOffScreen = false;


//we will have to eventually pass in a color here when spawnTarget is called 
//as we dont want all of the targets to have the the same colour
  Target(this.game, double x, double y){
    tarRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    tarPaint = Paint();
    tarPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c){
    c.drawRect(tarRect, tarPaint);
  }

  void update(double t){
    //move the targets can use translation method for Rect objects
    if(isHit == true){
      tarRect = tarRect.translate(0, game.tileSize * 5 * t);
    }else{
      //add functionality here to move based on its starting position
      tarRect = tarRect.translate(game.tileSize * 2 * t, 0);
    }
    if(tarRect.top > game.screenSize.height){
      isOffScreen = true;
    }
    //I'll have to add functionality here so it knows what side it started on and what side it should have hit in order to delete
    if(tarRect.left > game.screenSize.width){
      isOffScreen = true;
    }
  }

  void onTapDown(){
    tarPaint.color = Color(0xffff4757);
    isHit = true;
    // game.spawnFly();

  }

}