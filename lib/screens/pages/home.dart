// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/screens/search.dart';
import 'package:news_app/services/data_service.dart';
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
  dialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Choose Language'),
            children: <Widget>[
              Divider(),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    language = 'ar';
                  });
                  Navigator.pop(context);
                },
                child: Text('Arabic'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    language = 'nl';
                  });
                  Navigator.pop(context);
                },
                child: Text('Dutch'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    language = 'en';
                  });
                  Navigator.pop(context);
                },
                child: Text('English'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    language = 'he';
                  });
                  Navigator.pop(context);
                },
                child: Text('Hebrew'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    language = 'ru';
                  });
                  Navigator.pop(context);
                },
                child: Text('Russian'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    language = 'es';
                  });
                  Navigator.pop(context);
                },
                child: Text('Spanish'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
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
                      title: Row(
                        children: [
                          Text("News App"),
                        ],
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              dialog();
                            });
                          },
                          icon: Icon(Icons.translate),
                        ),
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
                        indicatorWeight: 4,
                        tabs: <Widget>[
                          Tab(
                              icon: Icon(CupertinoIcons.news),
                              text: "All News"),
                          Tab(
                              icon: Icon(Icons.trending_up),
                              text: "Top Stories"),
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
