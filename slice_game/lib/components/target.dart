import 'dart:ui';
import 'dart:math';
import 'package:slice_game/components/split_targets.dart';
import 'package:slice_game/gameLoop.dart';

class Target {
  final GameLoop game;
  Rect tarRect;
  Paint tarPaint;
  bool isHit = false;
  bool isOffScreen = false;
  bool peakReached = false;
  int widthD, heightD;
  double xMove;
  double yMove;
  double peak;
  Random rand;
  Color theColor;

//we will have to eventually pass in a color here when spawnTarget is called
//as we dont want all of the targets to have the the same colour
  Target(this.game, double x, double y, this.theColor) {
    //generate random numbers for x and y translations
    //x translations will be dependent on where the cube starts along the x axis
    int min = 1;
    int min2 = 2;
    int maxY = 4; //this is 4 even though there is only 3 states because this method of randome range is exclusive for max but inclusive for min
    int maxX = 3; //this is 3 even though there is only 2 states because this method of randome range is exclusive for max but inclusive for min
    peak = game.screenSize.height / 3;
    yMove = -1;

    rand = Random();
    heightD = min2 + rand.nextInt(maxY - min2);
    widthD = min + rand.nextInt(maxX - min);

    tarRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    tarPaint = Paint();
    tarPaint.color = theColor;
  }

// this function will be used to return the correct values to plug into the
// translate method in update
// it takes in the width type of the jump stored as an int from 1-2
// and the height type of the jump stored as an int from 1-3
  void xTrans() {
    //double xMove;
    //check where the left side of the target is
    //if width is 2 (half) it can only go one way
    //assign it a + or - value respectively
    //if width is 1 check to make sure its close enough to go either way
    //if it can randomly assign it a + or - value
    //remember 0,0 is top left
    if (widthD == 2) {
      //1/2
      //this will make the xMove + or - here
      if (tarRect.left < ((game.screenSize.width / 2) - (game.tileSize / 2))) {
        xMove = 1;
      } else {
        xMove = -1;
      }
      //now multiply xMove based off of the value of heightD
      if (heightD == 3) {
        // half height
        xMove *= 3;
      } else if (heightD == 2) {
        //a third height
        xMove *= 2;
      } else if (heightD == 1) {
        // two thirds height
        xMove *= 4;
      }
    } else if (widthD == 1) {
      //1/4
      //check if its within 1/4 of a side if not random
      //if within 1/4 of a side go the other way
      if (tarRect.left < game.screenSize.width / 3) {
        xMove = 1;
      } else if (tarRect.left > (game.screenSize.width / 3) * 2) {
        xMove = -1;
      } else {
        int temp = 1 + rand.nextInt(3 - 1);
        if (temp == 1) {
          xMove = 1;
        } else {
          xMove = -1;
        }
      }
      //now multiply xMove based off of the value of heightD
      if (heightD == 3) {
        // half height
        xMove *= 1;
      } else if (heightD == 2) {
        //a third height
        xMove *= 0.5;
      } else if (heightD == 1) {
        // two thirds height
        xMove *= 1.5;
      }
    } else {
      print("error occured");
    }
    //if it hits a wall bounce off

    return; //xMove;
  }

  void yTrans(double peak) {
    //use yMove in here
    // if (isHit == true) {
    //   yMove = -8;
    //   return;
    // }

    // if (heightD == 1) {
    //   //as the square approaches peak reduce the y move towards 0 and
    //   //when it hits the peak have it sit at 0 for a frame

    // } else if (heightD == 2) {
    // } else if (heightD == 3) {}
    peakReached = true;
    if (peakReached == true) {
      yMove *= -1;
      
    }
    return;
  }

  double yPeak() {
    double peak;
    if (heightD == 3) {
      peak = (game.screenSize.height / 2);
    } else if (heightD == 2) {
      peak = game.screenSize.height / 3;
    } else if (heightD == 1) {
      peak = (game.screenSize.height / 3) * 2;
    } else {
      print("error occured");
    }
    return game.screenSize.height / 3;//peak;
  }

  void render(Canvas c) {
    c.drawRect(tarRect, tarPaint);
  }

  void update(double t) {
    //move the targets can use translation method for Rect objects
    double peak;
    peak = yPeak();

    if (tarRect.top == game.screenSize.height &&
        (peakReached == false && isHit == false)) {
      xTrans();
    }
    // if(peakReached == false){
    //   yTrans(peak);
    // }
    
    if ((tarRect.right + (game.tileSize / 2) >= game.screenSize.width && xMove > 0) ||
        (tarRect.left - (game.tileSize / 2) <= 0 && xMove < 0)) {
      xMove *= -1;
    }
    
    
    // if (isHit == true) {
    //   //tarRect = tarRect.translate(0, game.tileSize * 6 * t);
    // } else 
    // if (tarRect.bottom < (peak) && peakReached == false) {
    //   print(theColor);
    //   peakReached = true;
    //   yMove = 1;
    // } else 
    if (peakReached == true) {
      tarRect =
          tarRect.translate(game.tileSize * xMove * t, yMove * game.tileSize * (game.screenSize.height/game.speedMod) * t);
    } else {
      tarRect = tarRect.translate(game.tileSize * xMove * t, yMove * game.tileSize * (game.screenSize.height/game.speedMod) * t);
    }
    //this will probably be all i need as current plan is to have several jump types but all will result in a jump that begins and ends at the base of the screen
    if (tarRect.top > game.screenSize.height - (game.tileSize / 3) && (peakReached == true || isHit == true)) {
      isOffScreen = true;
      if (game.lives > 0 &&
          !isHit &&
          theColor.toString() == game.theGoal.goalPaint.color.toString()) {
        game.lives--;
      }
    }
  }

  void onTapDown() {
    tarPaint.color = Color(0xffff4757);

    if (isHit != true) {
      isHit = true;
      game.splitTargets.add(SplitTargets(game, tarRect.left, tarRect.top));
      //targets.add(Target(this, x, y, getRandomColour()));
      if (theColor.toString() == game.theGoal.goalPaint.color.toString()) {
        if(game.lives >= 0){
          game.score += 1;
        }
      } else {
        game.lives--;
      }
    }
    // game.spawnFly();
  }
}
