// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../category.dart';

class Sports extends StatefulWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Category().stories("Sports News", 4),
    );
  }
}
