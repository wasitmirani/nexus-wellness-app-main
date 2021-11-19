

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nexuswellness/assets/apiUrls.dart';
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/widgets/mainwidgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

   final _formKey = GlobalKey<FormState>();
     bool loading = false;

  loginUser() async {
       final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    var url = login_url;

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailcontroller.text.toString(),
        'password': passwordcontroller.text.toString(),
      }),
    );
    // print(response.body);
    if(response.statusCode==401 ){
 
      final snackBar = SnackBar(
      content: Text('Please Check your credentials'),
      duration: const Duration(milliseconds: 800),
      backgroundColor: Colors.redAccent,
  
      action: SnackBarAction(
        label: 'error',

        textColor: Colors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      // print("res2"+res.toString());
      if (res.length > 0) {
        setState(() {
          // print("res1"+res['access_token'].toString());
         
           prefs.setString("token", res['access_token']);
           Navigator.pushNamed(context, '/new/feeds'); 
          loading = false;
        });
      } else {         
        loading = false;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(children: <Widget>[
        appBackgroundScreen(),
        ListView(
          children: <Widget>[
            appLogo(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Welcome..", style: kTitleStyle),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Sign in To Continue..", style: ksubTitleGreenStyle),
            ),
           
            Form(
            key: _formKey,
            child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: TextFormField(
                  controller: emailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email address';
                      }
                      return null;
                    },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter a Email Address'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: TextFormField
                (
                  controller: passwordcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  obscureText: true,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter a Password'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width/1,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  onPressed: () {
                       if (_formKey.currentState!.validate()) {
                                    final snackBar = SnackBar(
                                      content: Text('Please wait'),
                                      backgroundColor: Colors.green,
                                      duration: const Duration(milliseconds: 800),
                                      action: SnackBarAction(
                                        label: 'success',
                                        textColor: Colors.white,
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
         Center(
            child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Color(kPrimaryColor)),
          ));
                                    loginUser();
                                    // Navigator.pushNamed(context, '/plans');  
                                  }
                    
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
              ),
            ),
            Divider(),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 60,
                    child: OutlineButton(
                      highlightedBorderColor: Color(kPrimaryColor),
                      borderSide:
                          BorderSide(width: 2, color: Color(kPrimaryColor)),
                      onPressed: () {
                        
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Continue With",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Image.asset(
                            "assets/images/gmail.png",
                            height: 20,
                            width: 20,
                          ), // icon
                          // text
                        ],
                      ),
                    ))),
            Divider(),
             ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
                  child:  GestureDetector(
                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Not a Member ",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      "SignUp",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: Color(kgreenColor)),
                                    ),
                                  ],
                                ),
                    onTap: () {
                     Navigator.pushNamed(context, '/signup');
                    }
                  )
         
            ),
          ],
        ),
      ]),
    );
  }
}
