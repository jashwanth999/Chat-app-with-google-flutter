import 'dart:async';

import 'package:chat_app/components/auth_navigation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => AuthNavigation()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      color: Colors.deepOrangeAccent,
      child: Text(
        "Destiny",
        style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold),
      ),
    ));
  }
}
