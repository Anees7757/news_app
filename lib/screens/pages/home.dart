// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:news_app/main.dart';
import 'package:news_app/screens/news_detail.dart';
import 'package:news_app/screens/search.dart';
import 'package:news_app/services/shared_prefrences.dart';
import 'package:news_app/tab/all_stories.dart';
import 'package:news_app/tab/headlines.dart';
import 'package:news_app/tab/popular.dart';
import 'package:news_app/tab/sports.dart';
import 'package:news_app/tab/top_stories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    titlelst = DataSharedPrefrences.getTitle();
    contentlst = DataSharedPrefrences.getContent();
    deslst = DataSharedPrefrences.getDes();
    newsTimelst = DataSharedPrefrences.getNewsTime();
    sourcelst = DataSharedPrefrences.getSource();
    authorlst = DataSharedPrefrences.getAuthor();
    urllst = DataSharedPrefrences.getUrl();
    imgUrllst = DataSharedPrefrences.getImgUrl();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: primaryColor,
    ));
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                floating: true,
                snap: true,
                pinned: true,
                title: Text("News App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                backgroundColor: primaryColor,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Search()),
                      );
                    },
                    icon: Icon(CupertinoIcons.search),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  indicatorWeight: 4,
                  tabs: <Widget>[
                    Tab(
                        icon: Icon(CupertinoIcons.news),
                        text: "All News"),
                    Tab(icon: Icon(Icons.trending_up), text: "Top Stories"),
                    Tab(icon: Icon(Icons.segment), text: "Headlines"),
                    Tab(
                        icon: Icon(Icons.local_fire_department),
                        text: "Popular"),
                    Tab(icon: Icon(Icons.sports_cricket), text: "Sports"),
                  ],
                ),
              ),
            ];
          },
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: TabBarView(
              children: <Widget>[
                AllStories(),
                TopStories(),
                Headlines(),
                Popular(),
                Sports(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
