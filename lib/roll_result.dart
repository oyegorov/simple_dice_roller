import 'package:flutter/material.dart';

class RollResult extends StatelessWidget {
  String rollValue;

  RollResult(this.rollValue);

  @override
  Widget build(BuildContext context) {
      return new Center(
        child: new InkWell(
          child: new Center(
              child: new Container(
            width: 200.0,
            height: 200.0,
            padding: const EdgeInsets.all(20.0),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: 
            new Center(child: 
            new Text(rollValue, style: new TextStyle(color: Colors.white, fontSize: 50.0))),
          )),
        ),
    );
  }
}
