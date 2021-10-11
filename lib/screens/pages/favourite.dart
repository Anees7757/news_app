// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/screens/news_detail.dart';
import 'package:news_app/services/shared_prefrences.dart';

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
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (titlelst.isEmpty)
      ? Colors.white
      : Colors.grey[200],
      body: (titlelst.isEmpty)
          ? Center(
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
            )
          : Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: titlelst.length,
                      itemBuilder: (BuildContext context, index) {
                        return SafeArea(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    height: 100,
                                    child: Card(
                                      elevation: 4.0,
                                      shadowColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: AspectRatio(
                                            aspectRatio: 1.2,
                                            child: Image.network(
                                              imgUrllst[index],
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
                                        title: Text(titlelst[index],
                                            maxLines: 3,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            )),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Detail(
                                                title: 'Favourites',
                                                link: urllst[index],
                                                newsTitle: titlelst[index],
                                                content: contentlst[index],
                                                img: imgUrllst[index],
                                                newsTime: newsTimelst[index],
                                                source: sourcelst[index],
                                                author: authorlst[index],
                                                des: deslst[index],
                                                index: index,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(-6.0, -11.0, 0.0),
                                child: IconButton(
                                  icon: Icon(CupertinoIcons.clear_circled_solid,
                                      color: Colors.red, size: 32),
                                  onPressed: () async {
                                    setState(() {
                                      titlelst.removeAt(index);
                                      contentlst.removeAt(index);
                                      deslst.removeAt(index);
                                      sourcelst.removeAt(index);
                                      newsTimelst.removeAt(index);
                                      authorlst.removeAt(index);
                                      urllst.removeAt(index);
                                      imgUrllst.removeAt(index);
                                    });
                                    await DataSharedPrefrences.setTitle(
                                        titlelst);
                                    await DataSharedPrefrences.setContent(
                                        contentlst);
                                    await DataSharedPrefrences.setDes(deslst);
                                    await DataSharedPrefrences.setDes(
                                        sourcelst);
                                    await DataSharedPrefrences.setDes(
                                        newsTimelst);
                                    await DataSharedPrefrences.setDes(
                                        authorlst);
                                    await DataSharedPrefrences.setDes(urllst);
                                    await DataSharedPrefrences.setDes(
                                        imgUrllst);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
