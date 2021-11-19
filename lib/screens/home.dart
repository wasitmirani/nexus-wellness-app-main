import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/widgets/mainwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      children: <Widget>[
        appBackgroundScreen(),
        ListView(
          children: <Widget>[
            appLogo(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Center(
                child: Text(
                  "Nexus Wellness Solutions provide referrals for important services for communities, families, and individuals.",
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Column(children: <Widget>[
                                Text(
                                    "Explore the app for more information on Housing Stability, Food Assistance, and information on qualified service providers for vaccinations and COVID-19 testing."),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    "Premium plan for you Free- all levels of memberships get access to updated articles, event photos, and products. 0.99 members- get priority for wellness questions to be answered and life skills support class materials"),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    "\$9.99 members-get priority for wellness questions to be answered, life skills support class materials, and discounts on event tickets and purple table talk events"),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 60,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        color: Color(kPrimaryColor),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "OR",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 60,
                        child: OutlineButton(
                          highlightedBorderColor: Color(kPrimaryColor),
                          borderSide:
                              BorderSide(width: 2, color: Color(kPrimaryColor)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Color(kPrimaryColor)),
                          ),
                        ))),
              ],
            ),
            Divider(),
          ],
        ),
      ],
    ));
  }
}
