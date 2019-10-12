import 'package:flutter/material.dart';
import './menu_buttons.dart';

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
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MenuButtons(
            buttonText: "Play",
            onCliked: widget.onPlayPressed,
          ),
          MenuButtons(
            buttonText: "High Score",
            onCliked: widget.onHighScorePressed,
          ),
          MenuButtons(
              buttonText: "User Profile",
              onCliked: widget.onPlayerProfilePressed),
        ],
      ),
    );
  }
}
