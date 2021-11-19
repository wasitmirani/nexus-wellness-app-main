import 'package:flutter/material.dart';
import 'package:nexuswellness/assets/constants.dart';

Widget eventCard(title, img) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(img),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                    style:
                        TextStyle(fontSize: 18, color: Color(kPrimaryColor))),
              )
            ],
          )),
    ),
  );
}
