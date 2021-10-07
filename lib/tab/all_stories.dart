import 'package:flutter/material.dart';
import 'package:news_app/category.dart';

class AllStories extends StatefulWidget {
  const AllStories({ Key? key }) : super(key: key);

  @override
  _AllStoriesState createState() => _AllStoriesState();
}

class _AllStoriesState extends State<AllStories> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Category().stories("All News", 0),
    );
  }
}