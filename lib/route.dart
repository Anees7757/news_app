// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/pages/profile.dart';
import 'package:news_app/screens/registration.dart';

class RoutePage extends StatelessWidget {
  RoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if(snapshot.hasData) {
            return Profile();
          } else if(snapshot.hasError) {
            return Center(child: Text('Something Went Wrong!'));
          } else {
            return Reg();
          }
        },
      );
  }
}
