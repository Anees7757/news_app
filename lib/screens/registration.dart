// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/auth/signup.dart';

class Reg extends StatefulWidget {
  const Reg({ Key? key }) : super(key: key);

  @override
  _RegState createState() => _RegState();
}

class _RegState extends State<Reg> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login or Signup to continue"),
              SizedBox(height: 50),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text("LOGIN"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text("SIGNUP"),
                ),
              ),
            ],
          ),
        ),
    );
  }
}