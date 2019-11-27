import 'package:flutter/material.dart';
import './menu_buttons.dart';
import 'dart:math';

class StartMenu extends StatefulWidget {
  final Function() onPlayPressed;
  final Function() onHighScorePressed;
  final Function() onPlayerProfilePressed;
  StartMenu({
    @required this.onPlayPressed,
    @required this.onHighScorePressed,
    @required this.onPlayerProfilePressed,
  });
  _StartMenuState createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu> {

  Color randomColor() {
    List<Color> totalListColours = [
      Color(0xff00a025), //green
      Color(0xff0032f7), //blue
      Color(0xff7f169e), //purple
      Color(0xffff8ac3), //pink
      Color(0xff643b07), //brown
      Color(0xff008e83), //teal
      Color(0xfffff617), //yellow
      Color(0xfffd7c00), //orange
      Color(0xff6d7516), //olive
      Color(0xffcdaaf2), //lavender
      Color(0xff630120), // maroon
      Color(0xff001942), //navyblue
      Color(0xff002601), //darkgreen
      Color(0xffb30062), //magenta
      Color(0xff320a33), //darkpurple
    ];
    var rng = new Random();
    return totalListColours[rng.nextInt(totalListColours.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 1,
      
      child: Container(
        //color: randomColor(),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: <Widget>[

          MenuButtons(
            buttonText: "Play",
            onCliked: widget.onPlayPressed,
            theColor: randomColor(),
          ),
          MenuButtons(
            buttonText: "High Score",
            onCliked: widget.onHighScorePressed,
            theColor: randomColor(),
          ),
          MenuButtons(
              buttonText: "User Profile",
              onCliked: widget.onPlayerProfilePressed,
              theColor: randomColor(),
          ),

        ],
      ),
      ),
    );
  }
}
