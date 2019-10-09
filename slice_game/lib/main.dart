import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
static const String _title = 'Slice Game';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '_title',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
    ));
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            // child: const SizedBox(height: 30, width: 300),
            child:ButtonTheme(
              minWidth: 200,
              height: 70,
              child:RaisedButton(
                onPressed: () {},
                child: Text('Play', style: TextStyle(fontSize: 30, color: Colors.white)),
              )
            )
          ),
            Center(
            // child: const SizedBox(height: 30, width: 300),
            child:ButtonTheme(
              minWidth: 200,
              height: 70,
              child:RaisedButton(
                onPressed: () {},
                child: Text('High Score', style: TextStyle(fontSize: 30, color: Colors.white)),
              )
            )
          ),
            Center(
            // child: const SizedBox(height: 30, width: 300),
            child:ButtonTheme(
              minWidth: 200,
              height: 70,
              child:RaisedButton(
                onPressed: () {},
                child: Text('User Profile', style: TextStyle(fontSize: 30, color: Colors.white)),
              )
            )
          ),
        ],
      ),
    );
  }
}