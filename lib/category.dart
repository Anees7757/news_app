// ignore_for_file: prefer_const_constructors, unused_label, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/data_model.dart';
import 'package:news_app/screens/loading.dart';
import 'package:news_app/screens/pages/home.dart';
import 'package:news_app/services/data_service.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'main.dart';
import 'screens/news_detail.dart';

DataService _dataService = DataService();

class Category {
  stories(String title, int num) {
    return RefreshIndicator(
      onRefresh: () async {
        setState:
        () {
          _dataService.getArticle(num);
        };
      },
      strokeWidth: 3,
      child: FutureBuilder(
          future: _dataService.getArticle(num),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                    return true;
                  },
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(7),
                                          height: 185.0,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              "${articles![index].urlToImage}",
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Center(
                                                  child: Icon(
                                                      Icons.broken_image,
                                                      size: 90,
                                                      color: Colors.grey),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.only(left: 10),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              child: Text(
                                                timeago.format(DateTime.parse(
                                                    articles[index]
                                                        .publishedAt
                                                        .toString())),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          alignment: (language == 'ar')
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          child: Column(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text("${articles[index].title}",
                                                  textAlign: (language == 'ar')
                                                      ? TextAlign.right
                                                      : TextAlign.start,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  )),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                articles[index].description !=
                                                        null
                                                    ? "${articles[index].description}"
                                                    : "${articles[index].content}",
                                                textAlign: (language == 'ar')
                                                    ? TextAlign.right
                                                    : TextAlign.start,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Detail(
                                      title: title,
                                      link: "${articles[index].url}",
                                      newsTitle: "${articles[index].title}",
                                      content: "${articles[index].content}",
                                      img: "${articles[index].urlToImage}",
                                      newsTime:
                                          "${articles[index].publishedAt}",
                                      source: "${articles[index].source.name}",
                                      author: "${articles[index].author}",
                                      des: "${articles[index].description}",
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 5),
                          ],
                        );
                      }),
                ),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              print("api error");
            }
            if (num != 5) {
              return Loading();
            }
            return Container();
          }),
    );
  }
}
