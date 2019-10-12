import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slice_game/pages/home_page.dart';

void main() => runApp(SliceGame());


class SliceGame extends StatelessWidget {
  static const String _title = "Slice Game";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: _title),
    );
  }
}
