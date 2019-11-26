import 'package:flutter/material.dart';

class MenuButtons extends StatelessWidget {
  final String buttonText;
  final Function() onCliked;
  final Color theColor;

  MenuButtons({
    @required this.buttonText,
    @required this.onCliked,
    @required this.theColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      //child: const SizedBox(height: 30, width: 300),
      child: ButtonTheme(
        minWidth: 250,
        height: 100,
        child: RaisedButton(
          onPressed: this.onCliked,
          splashColor: Colors.indigoAccent,
          color: theColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
