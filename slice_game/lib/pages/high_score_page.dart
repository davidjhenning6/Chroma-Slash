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
        child: ListView.separated(
          itemCount: Server.highScores.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                children: <Widget>[
                  Text("${index+1}      ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Text("Name: ${Server.highScores[index].name}     ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Text("Score: ${Server.highScores[index].score}", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          },
          separatorBuilder: (context, index){
            return Divider(thickness: 2.0,);
          },
        ),
      ),
    );
  }
}
