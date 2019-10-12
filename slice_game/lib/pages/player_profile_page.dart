import 'package:flutter/material.dart';

class PlayerProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayerProfileState();
  }
}

class _PlayerProfileState extends State<PlayerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Container(),
    );
  }
}
