import 'dart:ui';
import 'package:slice_game/gameLoop.dart';


class SplitTargets{
  final GameLoop game;
  Rect tarRect1;
  Paint tarPaint1;
  Rect tarRect2;
  Paint tarPaint2;
  double splitTileSize;
  Color theColor;
  bool isOffScreen1 = false;
  bool isOffScreen2 = false;

  //this will recieve the x and y coordinate of 
  SplitTargets(this.game, double x, double y){
    //print("hi");
    splitTileSize = game.tileSize / 1.5;
    theColor = Color(0xffff4757);
    //print("x = $x ; y = $y");


    tarRect1 = Rect.fromLTWH(x, y+splitTileSize, splitTileSize, splitTileSize);
    tarPaint1 = Paint();
    tarPaint1.color = theColor;
    tarRect2 = Rect.fromLTWH(x+splitTileSize, y+splitTileSize, splitTileSize, splitTileSize);
    tarPaint2 = Paint();
    tarPaint2.color = theColor;
    

  }

  update(double t){
    if(!isOffScreen1){
      tarRect1 = tarRect1.translate(game.tileSize * -2 * t, game.tileSize * 8 * t);
      isOffScreen1 = isOffScreen(tarRect1);
    }
    if(!isOffScreen2){
      tarRect2 = tarRect2.translate(game.tileSize * 2 * t, game.tileSize * 8 * t);
      isOffScreen2 = isOffScreen(tarRect2);
    }
    
  }

  bool isOffScreen(Rect tarRect){
    if(tarRect.top >= game.screenSize.height 
      || tarRect.right <= 0 
      || tarRect.left >= game.screenSize.width ){
      return true;
    }
    return false;
  }

  render(Canvas c){
    if(!isOffScreen1){
      c.drawRect(tarRect1, tarPaint1);
    }
    if(!isOffScreen2){
      c.drawRect(tarRect2, tarPaint2);
    }

  }

}