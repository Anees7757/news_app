// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../category.dart';

class Headlines extends StatefulWidget {
  const Headlines({Key? key}) : super(key: key);

  @override
  _HeadlinesState createState() => _HeadlinesState();
}

class _HeadlinesState extends State<Headlines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Category().stories("Headlines", 2),
    );
  }
}
