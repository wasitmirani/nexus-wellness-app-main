import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

Widget videoCard(context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(right: 10),
          height: 200,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              Text(
                "There are many variations of passages There are many variations of passages",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "There are many variations of passages There are many variations of passages",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 200,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              Text(
                "There are many variations of passages There are many variations of passages",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
