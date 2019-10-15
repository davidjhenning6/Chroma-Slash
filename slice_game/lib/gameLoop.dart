import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:slice_game/components/target.dart';

class GameLoop extends Game{
  Size screenSize;
  double tileSize;
  List<Target> targets;
  Random rand;

  GameLoop(){
    initialize();
  }

  void initialize() async {
    targets = List<Target>();
    rand = Random();
    resize(await Flame.util.initialDimensions());
    spawnTarget();
  }

  spawnTarget(){
    double x = rand.nextDouble() * (screenSize.width - tileSize);
    double y = rand.nextDouble() * (screenSize.height - tileSize);
    targets.add(Target(this, x, y));
  }

  void render(Canvas canvas){
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);

    targets.forEach((Target targets)=> targets.render(canvas));
  }

  void update(double t){
    targets.forEach((Target targets)=> targets.update(t));
  }

  void resize(Size size){
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d){
    targets.forEach((Target targets){
      if(targets.tarRect.contains(d.globalPosition)){
        targets.onTapDown();
      }
    });

  }

}