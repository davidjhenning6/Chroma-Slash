import 'package:flutter/material.dart';

TextEditingController myController = new TextEditingController();

class PlayerProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayerProfileState();
  }
}

class _PlayerProfileState extends State<PlayerProfilePage> {
  //final myController = TextEditingController();
  //static var = myController 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Name'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Enter your player name'
            ),
            controller: myController,
            
          ), 
        ),
      )

    );
  }
}
