import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slice_game/components/no_back_route.dart';
import 'package:slice_game/pages/high_score_page.dart';
import 'package:slice_game/pages/player_profile_page.dart';
import 'package:slice_game/pages/play_page.dart';

import '../widgets/start_menu.dart';

class HomePage extends StatefulWidget {
  final title;
  HomePage({this.title = 'Slice Game'});
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  void playerProfilePressed() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => PlayerProfilePage()),
    );
  }

  void highScorePressed() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => HighScorePage()),
    );
  }

  void playPressed() {
    Navigator.push(
      context,
      NoBackRoute(builder: (context) => PlayPage()),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
      body: StartMenu(
        onHighScorePressed: highScorePressed,
        onPlayerProfilePressed: playerProfilePressed,
        onPlayPressed: playPressed,
      ),
    );
  }
}
