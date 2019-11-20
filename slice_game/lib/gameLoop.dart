import 'dart:ui';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:slice_game/components/bladePixel.dart';
import 'package:slice_game/components/split_targets.dart';
import 'package:slice_game/components/target.dart';
//import 'package:slice_game/components/score_counter.dart';
import 'package:slice_game/components/goal.dart';
import 'package:slice_game/components/life_count.dart';
//import 'package:slice_game/pages/home_page.dart';
import 'package:slice_game/components/pause.dart';
import 'package:slice_game/components/score_count.dart';
import 'package:slice_game/components/restart_game.dart';
import 'package:slice_game/components/quit.dart';
import 'package:slice_game/components/pause_text.dart';
import 'package:slice_game/firebase/server.dart';
//import 'package:slice_game/components/game_over.dart';

///import 'package:slice_game/components/randomColours.dart';

class GameLoop extends Game {
  //Function quitFunction;
  BuildContext context;
  Size screenSize;
  double tileSize;
  List<Target> targets;
  List<SplitTargets> splitTargets;
  List<BladePixel> bladePixels;
  Random rand;
  int score;
  int lives;
  int otherThrowCount;
  bool isPaused;
  //ScoreCounter scoreCounter;
  ScoreCount scoreCount;
  //RandomColour randColour;
  RestartGame restart;
  Goal theGoal;
  //GameOver gameOverText;
  Pause thePause;
  LifeCount livesScr;
  Quit quit;
  PauseText pauseText;
  int currentLevel;
  int gameThrowCount;
  bool isGameOver;
  //double timeSinceLastSpawn;
  int groupSize;
  int currentGroupSize;
  List<GestureRecognizer> swipeGestures = [];

  GameLoop(this.context) {
    initialize();
    var ges = createDragRecognizer();
    swipeGestures.add(ges);
    Flame.util.addGestureRecognizer(ges);
  }

  GestureRecognizer createDragRecognizer() {
    return new PanGestureRecognizer()
      ..onUpdate = (DragUpdateDetails update) => this.handleDragUpdate(update);
  }

  List<Color> totalListColours = [];
  
  Color getRandomColour() {
    List<Color> tempColourList = [];
    var rng = new Random();
    for(var i = 0 ; i < totalListColours.length; i++) {
      if (score < 3) {
        if(i == 3) break;
      }
      else if (score < 10) {
        if(i == 7) break;
      }
      tempColourList.add(totalListColours[i]);
    }
    var val = tempColourList[rng.nextInt(tempColourList.length)];
    return val;
  }

  void setUpColourList() {
    totalListColours = [
      Color(0xff00a025), //green
      Color(0xff0032f7), //blue
      Color(0xff7f169e), //purple
      Color(0xffff8ac3), //pink
      Color(0xff643b07), //brown
      Color(0xff008e83), //teal
      Color(0xfffff617), //yellow
      Color(0xfffd7c00), //orange
      Color(0xffb0e8ff), //lightblue
      Color(0xff14fbfc), //cyan
      Color(0xff6d7516), //olive
      Color(0xffcdaaf2), //lavender
      Color(0xff630120), // maroon
      Color(0xff001942), //navyblue
      Color(0xff002601), //darkgreen
      Color(0xffb30062), //magenta
      Color(0xff320a33), //darkpurple
    ];
  }


  void initialize() async {
    targets = List<Target>();
    splitTargets = List<SplitTargets>();
    bladePixels = List<BladePixel>();
    rand = Random();
    score = 0;
    lives = 20;
    currentLevel = 0;
    isPaused = false;
    currentGroupSize = 0;
    setUpColourList();
    gameThrowCount = 1;
    otherThrowCount = 1;
    isGameOver = false;
    resize(await Flame.util.initialDimensions());

    scoreCount = ScoreCount(this);
    theGoal = Goal(this);
    thePause = Pause(this);
    livesScr = LifeCount(this);
    restart = RestartGame(this);
    quit = Quit(this);
    pauseText = PauseText(this);
    Server.init();
  }

  void spawnTarget(/*double delay*/) {
    int min = 0;
    int max = (screenSize.width - tileSize).round();
    double x, y;
    int tempX;
    int i = 0;

    y = screenSize.height;    
    tempX = min + rand.nextInt(max - min);
    x = tempX.toDouble();
    //x is the left side of the target so check if any other tile is in the current tile
    //loop through each of the existing targets to check if there exists another target at that position
    if (targets.length == 0) {
      targets.add(Target(this, x, y, getRandomColour()));
    } else {
      while (i < targets.length) {
        print("i'm getting stuck here");
        if ( targets[i].tarRect.bottom >= screenSize.height &&
            (((x + tileSize) >= targets[i].tarRect.right) && (x <= targets[i].tarRect.right)) ||
            (((x + tileSize) >= targets[i].tarRect.left) && (x <= targets[i].tarRect.left))) {
          tempX = min + rand.nextInt(max - min);
          x = tempX.toDouble();
          i = 0;
        } else {
          i++;
        }
        //if a match is met reset i to 0 to check all of them again
      }//end while
      targets.add(Target(this, x, y, getRandomColour()));
    }//else end
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);

    //render background before score but render score before targets
    //scoreCounter.render(canvas);

    theGoal.render(canvas);
    livesScr.render(canvas);
    thePause.render(canvas);
    scoreCount.render(canvas);
    restart.render(canvas);
    quit.render(canvas);

    //render targets at the end so they are at the forefront
    targets.forEach((Target targets) => targets.render(canvas));
    splitTargets.forEach((SplitTargets splitTargets) => splitTargets.render(canvas));
    if (bladePixels.length > 0) {
      bladePixels.removeAt(0); //remove happens slower than render so it creates a cool effect hope it works out :)
    }
    if(bladePixels.length > 20){
      bladePixels.removeAt(0);
    }
    bladePixels.forEach((BladePixel bladePixel) => bladePixel.render(canvas));
    if (isPaused) {
      pauseText.render(canvas);
    }
  }

  void update(double t) {
    int outer = 0;
    int inner = 0;
    //do collision check here that way after both targets are flipped they can be retested for wall collision
    if (!isPaused) {
      targets.forEach((Target targets) => targets.update(t));
      splitTargets.forEach((SplitTargets splitTargets) => splitTargets.update(t));
      splitTargets.removeWhere((SplitTargets splitTargets) => splitTargets.isOffScreen1 && splitTargets.isOffScreen2 );
      targets.removeWhere((Target targets) => targets.isHit || targets.isOffScreen);
      if (targets.length > 1) {
        for (outer = 0; outer < targets.length; outer++) {
          //loop through each
          for (inner = 0; inner < targets.length; inner++) {
            //loop through remaining
            if (inner != outer &&
                targets[outer].tarRect.top < screenSize.height &&
                targets[inner].tarRect.top < screenSize.height) {
              //flip both that way once it gets to inner as outer it will not catch as the x will already be flipped
              if ((targets[outer].tarRect.center.dy -
                          targets[inner].tarRect.center.dy)
                      .abs() <=
                  tileSize + (tileSize / 8)) {
                //check to see if they are within the height
                if ((targets[outer].tarRect.center.dx -
                            targets[inner].tarRect.center.dx)
                        .abs() <=
                    tileSize + (tileSize / 8)) {
                  //check if they are within a tileSize width wise
                  if (targets[outer].tarRect.center.dx <
                      targets[inner].tarRect.center.dx) {
                    //if outer is to the left
                    if ((targets[outer].xMove >= 0) &&
                        (targets[inner].xMove <= 0)) {
                      targets[outer].xMove *= -1;
                      targets[inner].xMove *= -1;
                    } else if ((targets[outer].xMove > 0) &&
                            (targets[inner].xMove > 0) ||
                        (targets[outer].xMove < 0) &&
                            (targets[inner].xMove < 0)) {
                      if (targets[outer].xMove > targets[inner].xMove) {
                        targets[outer].xMove *= -1;
                      } else {
                        targets[inner].xMove *= -1;
                      }
                    }
                  } else {
                    //if outer is to the right
                    if ((targets[outer].xMove <= 0) &&
                        (targets[inner].xMove >= 0)) {
                      targets[outer].xMove *= -1;
                      targets[inner].xMove *= -1;
                    } else if ((targets[outer].xMove > 0) &&
                            (targets[inner].xMove > 0) ||
                        (targets[outer].xMove < 0) &&
                            (targets[inner].xMove < 0)) {
                      if (targets[outer].xMove > targets[inner].xMove) {
                        targets[outer].xMove *= -1;
                      } else {
                        targets[inner].xMove *= -1;
                      }
                    }
                  }
                } //dx check proximity
              } //dy check proximity
            } //check that inner and outer are not equal
          } //inner loop
        } //outer loop
      }
    }
    //add a check to make sure that all of the targets are off the screen and if they are send the next wave
    var milliSec = 300;
    if (targets.isEmpty && splitTargets.isEmpty) {
      if (lives > 0) {
        theGoal.changeColour(getRandomColour());
        spawnTarget(/*0*/);
        
        currentGroupSize = 1;
      }
      //set groupSize based on score
      if (score >= 0 && lives > 0) {
        groupSize = 2;
        Future.delayed(Duration(milliseconds: milliSec), () => spawnTarget());
      } 
      if (score >= 3 && lives > 0) {
        groupSize = 3;
        Future.delayed(Duration(milliseconds: milliSec + 300), () => spawnTarget());
      }
      if (score >= 10 && lives > 0) {
        groupSize = 4;
        Future.delayed(Duration(milliseconds: milliSec ), () => spawnTarget());
      }
    }
 
    if (lives <= 0) {
      if(!isGameOver){
        Server.addScore(score);
      }
      isGameOver = true;
      lives = 0;
    }
    //scoreCounter.update(t);

    scoreCount.update(t);
    livesScr.update(t);
    thePause.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 6;
  }

  void onTapDown(TapDownDetails d) {
    //print("IM CURRENTLY PRESSED!!!!");
    //this has become obsolete because of slicing being implemented
    // if (!isPaused) {
    //   targets.forEach((Target targets) {
    //     if (targets.tarRect.contains(d.globalPosition)) {
    //       targets.onTapDown();
    //     }
    //   });
    // }
    if (thePause.pauseBorderRect.contains(d.globalPosition)) {
      thePause.onTapDown();
    }
    if (restart.restartBorderRect.contains(d.globalPosition)) {
      restart.onTapDown();
    }
    if (quit.quitBorderRect.contains(d.globalPosition)) {
      quit.onTapDown(context: context);
    }
  }

  void handleDragUpdate(DragUpdateDetails d) {
    // print("x,y");
    // print(d.globalPosition.dx);
    // print(d.globalPosition.dy);
    if (!isPaused) {
      bladePixels
          .add(BladePixel(this, d.globalPosition.dx, d.globalPosition.dy));
      targets.forEach((Target targets) {
        if (targets.tarRect.contains(d.globalPosition)) {
          targets.onTapDown();
        }
      });
    }
  }
}
