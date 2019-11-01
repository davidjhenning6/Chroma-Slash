import 'dart:ui';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:slice_game/components/target.dart';
import 'package:slice_game/components/score_counter.dart';
import 'package:slice_game/components/goal.dart';
import 'package:slice_game/components/life_count.dart';
import 'package:slice_game/pages/home_page.dart';
import 'package:slice_game/components/pause.dart';
import 'package:slice_game/components/score_count.dart';
import 'package:slice_game/components/restart_game.dart';
import 'package:slice_game/components/quit.dart';
import 'package:slice_game/components/pause_text.dart';
import 'package:slice_game/components/game_over.dart';

///import 'package:slice_game/components/randomColours.dart';

class GameLoop extends Game {
  //Function quitFunction;
  BuildContext context;
  Size screenSize;
  double tileSize;
  List<Target> targets;
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
  GameOver gameOverText;
  Pause thePause;
  LifeCount livesScr;
  Quit quit;
  PauseText pauseText;
  int currentLevel;
  int gameThrowCount;
  bool isGameOver;

  GameLoop(this.context) {
    initialize();
    //quitFunction
  }

  // TapGestureRecognizer createTapRecognizer() {
  //   return new TapGestureRecognizer()
  //     ..onTapDown = (TapDownDetails details) => this.handleInput(details.globalPosition);;
  // }

  List<Color> totalListColours = [];
  Color getRandomColour() {
    var rng = new Random();
    var val = totalListColours[rng.nextInt(3)];
    //print(val);
    return val;
  }

  void initialize() async {
    targets = List<Target>();
    rand = Random();
    score = 0;
    lives = 20;
    currentLevel = 0;
    isPaused = false;
    totalListColours = [
      Color(0xff6ab04c),
      Color(0xffffff00),
      Color(0xff0000ff)
    ];
    gameThrowCount = 1;
    otherThrowCount = 1;
    isGameOver = false;
    //currentLevel = 0;
    //randColour = RandomColour();
    resize(await Flame.util.initialDimensions());

    //scoreCounter = ScoreCounter(this);
    scoreCount = ScoreCount(this);
    theGoal = Goal(this);
    thePause = Pause(this);
    livesScr = LifeCount(this);
    restart = RestartGame(this);
    quit = Quit(this);
    pauseText = PauseText(this);
    gameOverText = GameOver(this);
    spawnTarget();
  }

  spawnTarget(){
    int min = 0;
    int max = (screenSize.width - tileSize).round() ;
    double x, y;
    int tempX;
    int i = 0;
    //int next=1;
    // int next = min + rand.nextInt(max - min);
    // if(next == 0){
    //   x = screenSize.width + tileSize;
    // }else{
    //   x = 0 - tileSize;
    // }

/* next step is to set the starting position of a target as bottom middle and time how long 
 * it remains on screen, to try and get an estimation on how far the tile needs to move 
 * per second
 *
 * i need to change the y translation to be -12 and then flip to 12 after the square reaches each
 * height i can hardcode each for now and then i'll need to implement each once the times and widths work
 * using my xTrans function in target.dart
 */

    //i want x to be 0-tilesize or screenSize.width get 1 or 0 from rand
    //double y = rand.nextDouble() * (screenSize.height - tileSize);
    y = screenSize.height;
    //x = (screenSize.width / 2) - (tileSize /2);
    tempX = min + rand.nextInt(max - min);
    x = tempX.toDouble();
    //x is the left side of the target so check if any other tile is in the current tile

    //loop through each of the existing targets to check if there exists another target at that position
    if( targets.length == 0){
      targets.add(Target(this, x, y, getRandomColour()));
      // print(tileSize);
      // print("0==");
      // print(x);
    } else {
      
      while(i < targets.length){
        //an x must be generated that will not exist inside another target
        //so x1 - tileSize > x2 or x1 + tileSize < x2
        //below checks if the targets will overlap
        if( ( (( x + tileSize ) >= targets[i].tarRect.right) && (x <= targets[i].tarRect.right )) || ( (( x + tileSize ) >= targets[i].tarRect.left) && (x <= targets[i].tarRect.left )) ){
          tempX = min + rand.nextInt(max - min);
          x = tempX.toDouble();
          i = 0;
        } else {
          i++;
        }
        //if a match is met reset i to 0 to check all of them again
      }
      targets.add(Target(this, x, y, getRandomColour()));
      // print("1==");
      // print(x);
    }
    
    // if(){

    // }
    
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
    if (isPaused) {
      pauseText.render(canvas);
    }

  }

  void update(double t){
    int outer = 0;
    int inner = 0;
    double tempSpeed = 0;
    if(lives <= 0) {
      //Navigator.pop(this);
      
      // Navigator.push(
      // context,
      // CupertinoPageRoute(builder: (context) => HomePage()),
      //);
    }
    //do collision check here that way after both targets are flipped they can be retested for wall collision
    
    targets.forEach((Target targets)=> targets.update(t));
    targets.removeWhere((Target targets)=> targets.isOffScreen);
    if(targets.length > 1){
      for(outer = 0; outer < targets.length; outer++){//loop through each
        for(inner = 0; inner < targets.length; inner++){//loop through remaining
          if(inner != outer && targets[outer].tarRect.top < screenSize.height && targets[inner].tarRect.top < screenSize.height){
            //flip both that way once it gets to inner as outer it will not catch as the x will already be flipped
            if( (targets[outer].tarRect.center.dy - targets[inner].tarRect.center.dy).abs() <= tileSize ){//check to see if they are within the height
              if((targets[outer].tarRect.center.dx - targets[inner].tarRect.center.dx).abs() <= tileSize){//check if they are within a tileSize width wise
                if(targets[outer].tarRect.center.dx < targets[inner].tarRect.center.dx ){//if outer is to the left 
                  if( ( targets[outer].xMove >= 0) && (targets[inner].xMove <= 0) ){
                    targets[outer].xMove *= -1;
                    targets[inner].xMove *= -1; 
                    //print("they collided");
                  }
                  // else if( (targets[outer].xMove * targets[inner].xMove).abs() > 0 ){
                  //   if(targets[outer].xMove > 0 && targets[outer].xMove >= targets[inner].xMove){
                  //     tempSpeed = targets[outer].xMove;
                  //     targets[outer].xMove = targets[inner].xMove;
                  //     targets[inner].xMove = tempSpeed;
                  //   }else if(targets[outer].xMove < 0 && targets[outer].xMove <= targets[inner].xMove){
                  //     tempSpeed = targets[outer].xMove;
                  //     targets[outer].xMove = targets[inner].xMove;
                  //     targets[inner].xMove = tempSpeed;
                  //   }
                  // }
                }else{//if outer is to the right
                  if( ( targets[outer].xMove <= 0) && (targets[inner].xMove >= 0) ){
                    targets[outer].xMove *= -1;
                    targets[inner].xMove *= -1; 
                    //print("they collided");
                  }
                  // else if( (targets[outer].xMove * targets[inner].xMove).abs() > 0 ){
                  //   if(targets[outer].xMove > 0 && targets[outer].xMove <= targets[inner].xMove){
                  //     tempSpeed = targets[outer].xMove;
                  //     targets[outer].xMove = targets[inner].xMove;
                  //     targets[inner].xMove = tempSpeed;
                  //   }else if(targets[outer].xMove < 0 && targets[outer].xMove >= targets[inner].xMove){
                  //     tempSpeed = targets[outer].xMove;
                  //     targets[outer].xMove = targets[inner].xMove;
                  //     targets[inner].xMove = tempSpeed;
                  //   }
                  // }
                }
                
              }//dx check proximity
            }//dy check proximity
          }//check that inner and outer are not equal
        }//inner loop

      }//outer loop
    }

    //add a check to make sure that all of the targets are off the screen and if they are send the next wave
    if(targets.isEmpty){
      if(lives > 0){
        spawnTarget();
        if(score >= 0){///////////change back
          spawnTarget();
          if (score >= 3) {
            spawnTarget();
          }
          if (score >= 10) {
            spawnTarget();
          }
          if (gameThrowCount == 3) {
            gameThrowCount = 0;
            //theGoal.changeColour(theGoal.theGoalColor);
          } else {
            theGoal.changeColour(getRandomColour());
          }
        } else {
          isGameOver = true;
        }
      }
      //scoreCounter.update(t);

      scoreCount.update(t);

      livesScr.update(t);
      thePause.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 6;
  }

  void onTapDown(TapDownDetails d) {
    print("IM CURRENTLY PRESSED!!!!");
    if (!isPaused) {
      targets.forEach((Target targets) {
        if (targets.tarRect.contains(d.globalPosition)) {
          targets.onTapDown();
        }
      });
    }
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

  // void quitGame() {
  //   BuildContext get currentContext => _currentElement;
  //   //Navigator.pop(this);
  // }

}
