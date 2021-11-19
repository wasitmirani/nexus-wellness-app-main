import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";
  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      token = prefs.getString('token').toString();

      if (token.length > 1 && token != "null") {
        Timer(
          Duration(seconds: 9),
          () => Navigator.pushNamed(context, '/new/feeds'),
        );
      } else {
        Timer(
          Duration(seconds: 9),
          () => Navigator.pushNamed(context, '/home'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      children: <Widget>[
        new Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('logo.gif', fit: BoxFit.cover)),
      ],
    ));
  }
}
