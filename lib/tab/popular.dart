// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../category.dart';

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Category().stories("Popular News", 3),
    );
  }
}
