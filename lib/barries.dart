// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {

  final size;

  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        border: Border.all(color: Colors.green[800]!, width: 10),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
