import 'package:flutter/material.dart';
import 'package:nexuswellness/assets/apiUrls.dart';
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/widgets/eventCard.dart';
import 'package:nexuswellness/widgets/mainDrawer.dart';
import 'package:nexuswellness/widgets/mainwidgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Events extends StatefulWidget {
  Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List events = [];
  bool loading = false;
  String name = "", email = "", id = "", plane = "", thumbnail = "";

  @override
  void initState() {
    super.initState();
    this.fetchEvents();
  }

  getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString('name').toString();
    id = prefs.getString('id').toString();
    thumbnail = prefs.getString('thumbnail').toString();
    email = prefs.getString('email').toString();
    plane = prefs.getString('plane').toString();
  }

  fetchEvents() async {
    setState(() {
      loading = true;
    });
    var url = events_api_url;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      if (items.length > 0) {
        setState(() {
          getUserInfo();
          events = items['events'];
          loading = false;
        });
      } else {
        events = [];
        loading = false;
      }
    }
  }

  Widget getEvents() {
    if (events.contains(null) || events.length < 0 || loading) {
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
          itemBuilder: (context, index) =>
              eventCard(events[index]['title'], events[index]['thumbnail']),
          itemCount: events.length,
        ),
      ]),
    );
  }

  Future<Null> _refreshEvents() async {
    setState(() {
      fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events Listing"),
      ),
      drawer: mainDrawer(name, email, thumbnail, context),
      body: new Stack(children: <Widget>[
        appBackgroundScreen(),
        RefreshIndicator(
          onRefresh: _refreshEvents,
          child: ListView(children: <Widget>[
            appLogo(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Upcoming Events", style: kTitleStyle),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Here's Our Upcoming Events",
                  style: ksubTitleGreenStyle),
            ),
            getEvents(),
          ]),
        ),
      ]),
    );
  }
}
