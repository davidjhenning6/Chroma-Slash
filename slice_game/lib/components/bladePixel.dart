import 'dart:ui';
import 'dart:math';
import 'package:slice_game/gameLoop.dart';

class BladePixel{
  final GameLoop game;
  Rect pixRect;
  Paint pixPaint;
  double x;
  double y;

  BladePixel(this.game, this.x, this.y){
    pixRect = Rect.fromLTWH(x, y, game.tileSize/10, game.tileSize/10);
    pixPaint = Paint();
    pixPaint.color = Color(0xffffffff);

  }

  remove(){

  }

  void render(Canvas c){
    c.drawRect(pixRect, pixPaint);
  }

  void update(double t){
        
  }

}