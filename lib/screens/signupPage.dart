

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nexuswellness/assets/apiUrls.dart';
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/widgets/mainwidgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
   TextEditingController namecontroller = new TextEditingController();
  

   final _formKey = GlobalKey<FormState>();
     bool loading = false;

  SigupUser() async {
       final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    var url = signup_user;

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailcontroller.text.toString(),
        'password': passwordcontroller.text.toString(),
        'name':namecontroller.text.toString(),
      }),
    );
    // print(response.body);
    
    if (response.statusCode == 201) {
      var res = json.decode(response.body);
      print("res2"+res.toString());
      if (res.length > 0) {
        setState(() {
          // print("res1"+res['access_token'].toString());
         
           prefs.setString("token", res['access_token']);
           Navigator.pushNamed(context, '/plans'); 
          loading = false;
        });
      } else {         
          ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please try agin'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                      ),
                                    );
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
              child: Text("Signup in To Continue..", style: ksubTitleGreenStyle),
            ),
           
            Form(
            key: _formKey,
            child: Column(
            children: [
               Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: TextFormField(
                  controller: namecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Full Name';
                      }
                      return null;
                    },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter a Full Name'),
                ),
              ),
            ),
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
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Proccessing Data..'),duration: Duration(milliseconds:400),),
                                    );
                                    SigupUser();
                                    // Navigator.pushNamed(context, '/plans');  
                                  }
                    
                  },
                  color: Color(kPrimaryColor),
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
            ),
         
          
            Divider(),
             ])),

                Padding(
              padding: const EdgeInsets.all(8.0),
                  child:  GestureDetector(
                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already a Member",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: Color(kgreenColor)),
                                    ),
                                  ],
                                ),
                    onTap: () {
                     Navigator.pushNamed(context, '/login');
                    }
                  )
         
            ),
           
          ],
        ),
      ]),
    );
  }
}
