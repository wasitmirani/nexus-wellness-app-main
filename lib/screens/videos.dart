import 'package:flutter/material.dart';
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/widgets/eventCard.dart';
import 'package:nexuswellness/widgets/mainwidgets.dart';
import 'package:nexuswellness/widgets/videoCard.dart';

class Videos extends StatefulWidget {
  Videos({Key? key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          appBackgroundScreen(),
          ListView(children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Our Videos", style: kTitleStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Our Videos Show Everything",
                      style: ksubTitleGreenStyle),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            videoCard(context),
          ])
        ],
      ),
    );
  }
}
