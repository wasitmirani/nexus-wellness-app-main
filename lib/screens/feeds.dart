import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nexuswellness/assets/apiUrls.dart';
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/widgets/mainDrawer.dart';
import 'package:nexuswellness/widgets/mainwidgets.dart';
import 'package:nexuswellness/widgets/postCard.dart';
import 'package:nexuswellness/widgets/storiesCard.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Feeds extends StatefulWidget {
  Feeds({Key? key}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  List articles = [];
  String name = "", email = "", id = "", plane = "", thumbnail = "";

  bool loading = false;

  @override
  void initState() {
    super.initState();
    this.fetchArticles();

    getAuthUser();
    // getUserInfo();
    // WidgetsBinding.instance.addPostFrameCallback((_) => getAuthUser());
  }

  getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString('name').toString();
    id = prefs.getString('id').toString();
    thumbnail = prefs.getString('thumbnail').toString();
    email = prefs.getString('email').toString();
    plane = prefs.getString('plane').toString();
  }

  getAuthUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    final response = await http.get(
      Uri.parse(auth_user),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
      },
    );
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print(items['user'].length);
      if (items['user'].toString().length > 0) {
        setState(() {
          print(items['user']['name'].toString());
          name = items['user']['name'].toString();
          email = items['user']['email'].toString();
          prefs.setString('name', items['user']['name'].toString());
          prefs.setString('id', items['user']['id'].toString());
          prefs.setString('thumbnail', items['user']['thumbnail'].toString());
          prefs.setString('email', items['user']['email'].toString());
          prefs.setString('plane', items['user']['plane'].toString());
        });
      } else {
        // loading = false;
      }
    }
  }

  fetchArticles() async {
    setState(() {
      loading = true;
    });
    var url = articles_api_url;
    final response = await http.get(Uri.parse(url));

    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      if (items.length > 0) {
        setState(() {
          articles = items['articles'];
          print(articles);
          loading = false;
        });
      } else {
        articles = [];
        loading = false;
      }
    }
  }

  Widget getArticles() {
    if (articles.contains(null) || articles.length < 0 || loading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(kPrimaryColor)),
      ));
    }
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(children: <Widget>[
        // **THIS is the important part**
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => storiesCard(
              articles[index]['title'],
              articles[index]['short_description'],
              articles[index]['thumbnail']),
          itemCount: articles.length,
        ),
      ]),
    );
  }

  Future<Null> _refreshArticles() async {
    setState(() {
      fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.delayed(const Duration(milliseconds: 500), () {
          exit(0);
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nexus Findings"),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Add your onPressed code here!
        //   },
        //   child: const Icon(Icons.message_outlined),
        //   backgroundColor: Color(kblueColor),
        // ),
        drawer: mainDrawer(name, email, thumbnail, context),
        body: new Stack(children: <Widget>[
          appBackgroundScreen(),
          RefreshIndicator(
            onRefresh: _refreshArticles,
            child: ListView(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("What You Really Need", style: kTitleStyle),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Text(
                    "here are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour,",
                    style: ksubTitleBlackStyle),
              ),
              postCard("Lorem Ipsum",
                  "here are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Read Stories..", style: kTitleStyle),
              ),
              SizedBox(
                height: 10,
              ),
              getArticles(),
              Divider(),
              SizedBox(
                height: 30,
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
