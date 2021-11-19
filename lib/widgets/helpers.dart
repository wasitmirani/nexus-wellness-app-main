import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helpers extends StatefulWidget {
  Helpers({Key? key}) : super(key: key);

  @override
  _HelpersState createState() => _HelpersState();
}

class _HelpersState extends State<Helpers> {
  getToken() async{
 final SharedPreferences prefs = await SharedPreferences.getInstance();
        var token;
         setState(() {
            token= prefs.getString('token').toString();
            
             Timer(
            Duration(milliseconds: 4),
            () => Navigator.pushNamed(context, '/home'),
          );
                  if(token.length>1 && token!="null" ){
              Timer(
                  Duration(seconds: 3),
                  () => Navigator.pushNamed(context, '/new/feeds'),
                  );
                  }
                  else {
                    Timer(
                    Duration(milliseconds: 4),
                  () => Navigator.pushNamed(context, '/home'),
                );
                  }
         });
     
}
  @override
  Widget build(BuildContext context) {
    return Container(
       child: null,
    );
  }
}