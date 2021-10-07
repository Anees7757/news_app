// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/category.dart';

Set<String> _favourites = <String>{};

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: (_favourites.isNotEmpty)
            ? Category().stories("Favourite", 5)
            : Center(
                child: Lottie.asset(
                  'assets/animation.json',
                  height: 300,
                  width: 300,
                  controller: _controller,
                  repeat: true,
                  reverse: true,
                  animate: true,
                  onLoaded: (composition) {
                    _controller!
                      ..duration = composition.duration
                      ..repeat();
                  },
                ),
              ),
        // ListView.builder(
        //     itemCount: 4,
        //     itemBuilder: (context, index) {
        //       return Container(
        //         margin: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        //         child: Card(
        //           color: Colors.white,
        //           shadowColor: Colors.grey,
        //           elevation: 2,
        //           child: SizedBox(
        //             child: Card(
        //               child: Container(
        //                 margin: EdgeInsets.all(10),
        //                 child: Column(
        //                   children: [
        //                     ListTile(
        //                       leading: Image.network(
        //                           "https://media.istockphoto.com/photos/breaking-news-world-news-with-map-backgorund-picture-id1182477852?k=20&m=1182477852&s=612x612&w=0&h=I3wdSzT_5h1y9dHq_YpZ9AqdIKg8epthr8Guva8FkPA=",
        //                           fit: BoxFit.cover),
        //                       title: Text("News title",
        //                           style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 19,
        //                           )),
        //                       subtitle: Text("Save Date"),
        //                     ),
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.end,
        //                       children: [
        //                         GestureDetector(
        //                             child: Icon(Icons.delete), onTap: () {}),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         GestureDetector(
        //                             child: Icon(Icons.share), onTap: () {}),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       );
        //     }),
      ),
    );
  }
}
