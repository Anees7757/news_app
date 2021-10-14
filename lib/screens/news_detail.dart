// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields, unnecessary_string_interpolations, unnecessary_null_comparison, unrelated_type_equality_checks

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/signup.dart';
import 'package:news_app/main.dart';
import 'package:news_app/screens/web_view.dart';
import 'package:news_app/services/data_service.dart';
import 'package:news_app/services/shared_prefrences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

List<String> titlelst = [];
List<String> contentlst = [];
List<String> deslst = [];
List<String> newsTimelst = [];
List<String> sourcelst = [];
List<String> authorlst = [];
List<String> urllst = [];
List<String> imgUrllst = [];

class Detail extends StatefulWidget {
  const Detail(
      {Key? key,
      required this.title,
      required this.link,
      required this.newsTitle,
      required this.content,
      required this.img,
      required this.newsTime,
      required this.source,
      required this.author,
      required this.des,
      required this.index})
      : super(key: key);

  final String link;
  final String title;
  final String newsTitle;
  final String content;
  final String img;
  final String newsTime;
  final String source;
  final String author;
  final String des;
  final int index;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  IconData _icon = CupertinoIcons.heart;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              final box = context.findRenderObject() as RenderBox?;

              await Share.share(
                  "${widget.newsTitle}\nCheck out full news at:\n${widget.link}",
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size);
            },
            icon: Icon(Icons.share),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Colors.grey,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  widget.img,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Center(
                      child: Icon(Icons.broken_image,
                          size: 90, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(left: 10, top: 10),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    "Source: ${widget.source}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(right: 20, bottom: 10),
              child: GestureDetector(
                  child: Icon(_icon, color: Colors.red, size: 30),
                  onTap: () async {
                    setState(() {
                      if (auth.currentUser == null) {
                        final snackBar = SnackBar(
                          duration: Duration(seconds: 10),
                          content: Text('Signup/Login First'),
                          action: SnackBarAction(
                            label: 'Signup',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        if (_icon == CupertinoIcons.heart) {
                          _icon = CupertinoIcons.heart_fill;
                          titlelst.add("${widget.newsTitle}");
                          contentlst.add("${widget.content}");
                          deslst.add("${widget.des}");
                          sourcelst.add("${widget.source}");
                          newsTimelst.add("${widget.newsTime}");
                          authorlst.add("${widget.author}");
                          urllst.add("${widget.link}");
                          imgUrllst.add("${widget.img}");
                          final snackBar =
                              SnackBar(content: Text('Saved as Favourite'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text('Favourite Removed'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () async {
                                setState(() {
                                  _icon = CupertinoIcons.heart_fill;
                                  titlelst.add("${widget.newsTitle}");
                                  contentlst.add("${widget.content}");
                                  deslst.add("${widget.des}");
                                  sourcelst.add("${widget.source}");
                                  newsTimelst.add("${widget.newsTime}");
                                  authorlst.add("${widget.author}");
                                  urllst.add("${widget.link}");
                                  imgUrllst.add("${widget.img}");
                                });
                                await DataSharedPrefrences.setTitle(titlelst);
                                await DataSharedPrefrences.setContent(
                                    contentlst);
                                await DataSharedPrefrences.setDes(deslst);
                                await DataSharedPrefrences.setSource(sourcelst);
                                await DataSharedPrefrences.setNewsTime(
                                    newsTimelst);
                                await DataSharedPrefrences.setAuthor(authorlst);
                                await DataSharedPrefrences.setUrl(urllst);
                                await DataSharedPrefrences.setImgUrl(imgUrllst);
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _icon = CupertinoIcons.heart;

                          titlelst.removeAt(widget.index);
                          contentlst.removeAt(widget.index);
                          deslst.removeAt(widget.index);
                          sourcelst.removeAt(widget.index);
                          newsTimelst.removeAt(widget.index);
                          authorlst.removeAt(widget.index);
                          urllst.removeAt(widget.index);
                          imgUrllst.removeAt(widget.index);
                        }
                      }
                    });
                    await DataSharedPrefrences.setTitle(titlelst);
                    await DataSharedPrefrences.setContent(contentlst);
                    await DataSharedPrefrences.setDes(deslst);
                    await DataSharedPrefrences.setDes(sourcelst);
                    await DataSharedPrefrences.setDes(newsTimelst);
                    await DataSharedPrefrences.setDes(authorlst);
                    await DataSharedPrefrences.setDes(urllst);
                    await DataSharedPrefrences.setDes(imgUrllst);
                  }),
            ),
            IntrinsicHeight(
              child: Stack(
                children: [
                  Align(
                    alignment: (language == 'ar')
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                        margin: (language == 'ar')
                            ? EdgeInsets.only(right: 12)
                            : EdgeInsets.only(left: 12),
                        child: VerticalDivider(
                          thickness: 4,
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                        )),
                  ),
                  Container(
                    margin: (language == 'ar')
                        ? EdgeInsets.only(left: 15, right: 32)
                        : EdgeInsets.only(left: 32, right: 15),
                    child: Text(widget.newsTitle,
                        textAlign: (language == 'ar')
                            ? TextAlign.right
                            : TextAlign.start,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.all(10),
                    child: Text(timeago.format(DateTime.parse(widget.newsTime)),
                        style: TextStyle(color: Colors.grey)),
                  ),
                  Divider(
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (widget.content != 'null')
                      ? Text("${widget.content}",
                          style: TextStyle(
                            fontSize: 17,
                          ))
                      : Text(''),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewPage(
                            link: widget.link,
                            title: widget.newsTitle,
                          ),
                        ),
                      );
                    },
                    child: Text(
                        (widget.content != 'null')
                            ? "Read More >>"
                            : "<< Read Here >>",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          // color: primaryColor,
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(10),
                      child: (widget.author != 'null')
                          ? Text("Author: ${widget.author}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor))
                          : Text("Author: Unknown",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor))),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
