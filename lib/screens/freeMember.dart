import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_authorize_net_client/flutter_authorize_net_client.dart';
import 'package:nexuswellness/assets/apiUrls.dart';
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/screens/PlansScreen.dart';
import 'package:nexuswellness/widgets/mainwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FreePlan extends StatefulWidget {
  FreePlan({Key? key}) : super(key: key);

  @override
  _FreePlanState createState() => _FreePlanState();
}

class _FreePlanState extends State<FreePlan> {
  bool loading = false;
  updateUserPlane(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    setState(() {
      loading = true;
    });
    var url = update_plane_user;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
      },
      body: {
        'plane_id': id.toString(),
      },
    );
    // print(response.statusCod);
    if (response.statusCode == 201) {
      Navigator.pushNamed(context, '/new/feeds');
    }
  }

  late AuthorizeNetClient _client;
  late String _refID;

  @override
  void initState() {
    super.initState();
    _client = AuthorizeNetClient(
      '49HYnF9ap3',
      '34X64r498YN9Hwtr',
      environment: AuthorizeNetClient.ENV_TEST,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kPrimaryColor),
        elevation: 0,
      ),
      body: new Stack(children: <Widget>[
        planBgScreen("freeplanbg.png"),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            child: ListView(
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text("Free Plan For You", style: kTitleStyle),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                  child: Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form,",
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Color(0xFFECECEC),
                        child: IconButton(
                          color: Colors.white,
                          iconSize: 60,
                          icon: Image.asset('assets/images/icons/article.png'),
                          tooltip: 'article',
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        color: Color(0xFFECECEC),
                        child: IconButton(
                          color: Colors.white,
                          iconSize: 60,
                          icon: Image.asset('assets/images/icons/covid.png'),
                          tooltip: 'covid',
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        color: Color(0xFFECECEC),
                        child: IconButton(
                          color: Colors.white,
                          iconSize: 60,
                          icon: Image.asset('assets/images/icons/path.png'),
                          tooltip: 'path',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(kPrimaryColor), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          print("hello");
                          // updateUserPlane('1');
                          final response = await _client.chargeCreditCard(
                            '10',
                            'USD'.toLowerCase(),
                            '5424000000000015',
                            '2022-12',
                            '123',
                          );
                          print('response: \n${response.toJson()}');
                          print('isSuccessFul: ${response.isSuccessful}');
                          print(jsonEncode(response.toJson()));
                        },
                        child: Text('Claim Free Plan'),
                      ),
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
