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
  ScoreCounter scoreCounter;
  //RandomColour randColour;
  Goal theGoal;
  LifeCount livesScr;
  int currentLevel;
  

  GameLoop(this.context){
    initialize();
    //quitFunction 
    
  }

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
    lives = 3;
    currentLevel = 0;
    totalListColours = [Color(0xff6ab04c), Color(0xffffff00), Color(0xff0000ff)];
    //currentLevel = 0;
    //randColour = RandomColour();
    resize(await Flame.util.initialDimensions());
    scoreCounter = ScoreCounter(this);
    theGoal = Goal(this);
    livesScr = LifeCount(this);
    spawnTarget();
    
  }

  spawnTarget(){
    int min=0;
    int max= (screenSize.width - tileSize).round() ;
    double x, y;
    int tempX;
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
    targets.add(Target(this, x, y, getRandomColour()));
  }

  void render(Canvas canvas){
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);

  //render background before score but render score before targets
    scoreCounter.render(canvas);
    theGoal.render(canvas);
    livesScr.render(canvas);

  //render targets at the end so they are at the forefront
    targets.forEach((Target targets)=> targets.render(canvas));
  }

  void update(double t){

    if(lives <= 0) {
      //Navigator.pop(this);
      
      // Navigator.push(
      // context,
      // CupertinoPageRoute(builder: (context) => HomePage()),
      //);
    }

    targets.forEach((Target targets)=> targets.update(t));
    targets.removeWhere((Target targets)=> targets.isOffScreen);

    //add a check to make sure that all of the targets are off the screen and if they are send the next wave
    if(targets.isEmpty){
      spawnTarget();
      if(score > 3){
        spawnTarget();
      }
    }
    scoreCounter.update(t);


    if(score == 5 && currentLevel == 0) {
      theGoal.changeColour(getRandomColour());
      currentLevel++;
    } else if(score == 10 && currentLevel == 1) {
      theGoal.changeColour(getRandomColour());
      currentLevel++;
    } else if(score == 15 && currentLevel == 2) {
      theGoal.changeColour(getRandomColour());
      currentLevel++;
    } else if(score == 20 && currentLevel == 3) {
      theGoal.changeColour(getRandomColour());
      currentLevel++;

    } 

    livesScr.update(t);
    
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

  // void quitGame() {
  //   BuildContext get currentContext => _currentElement;
  //   //Navigator.pop(this);
  // }

}