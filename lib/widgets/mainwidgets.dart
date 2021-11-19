import 'package:flutter/material.dart';

Widget appBackgroundScreen() {
  return Container(
    decoration:  BoxDecoration(
      image:  DecorationImage(
        image: AssetImage("assets/images/background.png"),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget appLogo() {
  return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/images/logo.png',
          height: 150, width: 150, fit: BoxFit.contain),
    ),
  );
}

Widget planBgScreen(path) {
  return Container(
    decoration: new BoxDecoration(
      image:  DecorationImage(
        image:  AssetImage("assets/images/" + path),
        fit: BoxFit.cover,
      ),
    ),
  );
}
