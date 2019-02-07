import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import './roll_result.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage() : super();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  String _value = '?';
  AnimationController _controller;
  Animation<double> _animation;
  Random _random = new Random();

  void _setValue(String newValue) {
    setState(() {
      _value = newValue;
      _controller.reset();
      _controller.forward();
    });
  }

  void _randomizeCoin() {    
    _setValue(_random.nextInt(2) == 1 ? 'HEADS' : 'TAILS');
  }

  void _randomizeValue(int max) {
    _setValue((_random.nextInt(max) + 1).toString());
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Simple Dice Roller'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeTransition(
                opacity: _animation,
                // The green box needs to be the child of the AnimatedOpacity
                child: RollResult(_value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => _randomizeValue(6),
                child: Text('D6'),
              ),
              FloatingActionButton(
                onPressed: () => _randomizeValue(20),
                child: Text('D20'),
              ),
              FloatingActionButton(
                onPressed: () => _randomizeValue(100),
                child: Text('D100'),
              ),
              FloatingActionButton(
                onPressed: _randomizeCoin,
                tooltip: 'Roll!',
                child: Icon(Icons.center_focus_strong),
              )
            ],
          ),
        ));
  }
}
