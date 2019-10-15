import 'dart:ui';
import 'package:slice_game/gameLoop.dart';

class Target{
  final GameLoop game;
  Rect tarRect;
  Paint tarPaint;
  bool isHit = false;


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
  }

  void onTapDown(){
    tarPaint.color = Color(0xffff4757);
    isHit = true;
    // game.spawnFly();

  }

}