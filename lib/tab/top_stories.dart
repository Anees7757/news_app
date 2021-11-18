// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:news_app/category.dart';

class TopStories extends StatefulWidget {
  const TopStories({Key? key}) : super(key: key);

  @override
  _TopStoriesState createState() => _TopStoriesState();
}

class _TopStoriesState extends State<TopStories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Category().stories("Top Stories", 1),
    );
  }
}
