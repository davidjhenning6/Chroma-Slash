import 'package:flutter/material.dart';
import 'package:slice_game/firebase/server.dart';

class HighScorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HighScoreState();
  }
}

class _HighScoreState extends State<HighScorePage> {
  @override
  void initState() {
    super.initState();
    Server.getHighScores(setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('High Scores'),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: <Widget>[
                  Text("Score:"),
                  Text("${Server.highScores[index]}")
                ],
              ),
            );
          },
          itemCount: Server.highScores.length,
        ),
      ),
    );
  }
}
