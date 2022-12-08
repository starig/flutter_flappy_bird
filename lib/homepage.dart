// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_flappy_bird/barries.dart';
import 'package:flutter_flappy_bird/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initHeight = birdYaxis;
  bool isGameStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0;

  void jump() {
    setState(() {
      time = 0;
      initHeight = birdYaxis;
    });
  }

  void start() {
    isGameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initHeight - height;

        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });

      setState(() {
        if (barrierXone < -1.4) {
          barrierXone += 3.4;
          score++;
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -1.4) {
          barrierXtwo += 3.4;
          score++;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (birdYaxis > 1) {
        timer.cancel();
        isGameStarted = false;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final _scoreStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25);

    final _bestScroreStyle = TextStyle(
        color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 25);

    return GestureDetector(
      onTap: () {
        if (isGameStarted) {
          jump();
        } else {
          start();
        }
      },
      child: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  duration: Duration(milliseconds: 244),
                  color: Colors.blueAccent,
                  child: MyBird(),
                ),
                Container(
                  alignment: Alignment(0, -0.3),
                  child: isGameStarted
                      ? Text('')
                      : Text(
                          'T A P  T O  P L A Y',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(barrierXone, 1.1),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(barrierXone, -1.1),
                  child: MyBarrier(
                    size: 250.0,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(barrierXtwo, 1.1),
                  child: MyBarrier(
                    size: 350.0,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 0),
                  alignment: Alignment(barrierXtwo, -1.1),
                  child: MyBarrier(
                    size: 100.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SCORE',
                        style: _scoreStyle,
                      ),
                      Text(score.toString(), style: _scoreStyle),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('BEST SCORE', style: _bestScroreStyle),
                      Text('10', style: _bestScroreStyle),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
