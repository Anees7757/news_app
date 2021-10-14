// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace, unused_import, unused_field, await_only_futures, unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:news_app/screens/edit.dart';
import 'package:news_app/screens/registration.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  LstTile(IconData _icon, String _title, String _subtitile) {
    return ListTile(
      leading: Icon(_icon),
      title: Text(_title),
      subtitle: Text(_subtitile),
    );
  }

  String imagePath = '';
  File? imageFile;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery).whenComplete(() {
      setState(() {
        if (imageFile != null) {
          dialog();
        }
      });
    });
    setState(() {
      imagePath = image!.path;
      if (imagePath != null) {
        imageFile = File(imagePath);
      }
    });
  }

  Future updateImage() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/${DateTime.now().toString()}.jpeg');

    File file = File(imagePath);

    await ref.putFile(file);
    String downloadUrl = await ref.getDownloadURL();
    if (db.collection("users").doc(auth.currentUser!.uid).collection('url') ==
        null) {
      await db.collection("users").doc(auth.currentUser!.uid).set({
        "url": downloadUrl,
      });
    } else {
      await db.collection("users").doc(auth.currentUser!.uid).update({
        "url": downloadUrl,
      });
    }
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0.0,
          content: CircleAvatar(
            radius: 100,
            backgroundImage: FileImage(imageFile!),
          ),
          actions: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      updateImage();
                      Navigator.pop(context);
                      setState(() {});
                      final snackBar =
                          SnackBar(content: Text('Avatar Updated'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: (db
                                .collection("users")
                                .doc(auth.currentUser!.uid)
                                .collection('url') !=
                            null)
                        ? Text("UPDATE")
                        : Text("SET"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return WillPopScope(
            onWillPop: () async => false,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: primaryColor,
                  elevation: 0.0,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Edit()),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 170,
                        width: double.infinity,
                        color: primaryColor,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 0,
                                        spreadRadius: 2,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 60,
                                    child: ClipOval(
                                      child: Image.network(
                                        data['url'] != null
                                            ? "${data['url']}"
                                            : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png",
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 80, left: 85),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[600],
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.camera_alt,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      LstTile(CupertinoIcons.person_fill, "Name",
                          "${data['name']}"),
                      LstTile(CupertinoIcons.mail_solid, "Email",
                          "${auth.currentUser?.email}"),
                      LstTile(CupertinoIcons.phone_fill, "Phone",
                          "${data['phone']}"),
                      LstTile(CupertinoIcons.map_fill, "Address",
                          "${data['address']}"),
                      LstTile(CupertinoIcons.creditcard_fill, "Payment Details",
                          "Unknown"),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title:
                            Text("Logout", style: TextStyle(color: Colors.red)),
                        onTap: () {
                          auth.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Reg()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
