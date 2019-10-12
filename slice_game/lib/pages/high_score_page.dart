import 'package:flutter/material.dart';

class HighScorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HighScoreState();
  }
}

class _HighScoreState extends State<HighScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('High Scores'),
      ),
      body: Container(),
    );
  }
}
