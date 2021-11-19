import 'package:flutter/material.dart';
import 'package:nexuswellness/assets/constants.dart';
import 'package:nexuswellness/screens/LoginPage.dart';
import 'package:nexuswellness/screens/PlansScreen.dart';
import 'package:nexuswellness/screens/SplashScreen.dart';
import 'package:nexuswellness/screens/customizePlan.dart';
import 'package:nexuswellness/screens/customizePlanPayment.dart';
import 'package:nexuswellness/screens/events.dart';
import 'package:nexuswellness/screens/feeds.dart';
import 'package:nexuswellness/screens/freeMember.dart';
import 'package:nexuswellness/screens/home.dart';
import 'package:nexuswellness/screens/premiumPlan.dart';
import 'package:nexuswellness/screens/premiumPlanePayment.dart';
import 'package:nexuswellness/screens/profile.dart';
import 'package:nexuswellness/screens/signupPage.dart';
import 'package:nexuswellness/screens/videos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Wellness',
      theme: ThemeData(
        primaryColor: Color(kPrimaryColor),
        accentColor: Color(kPrimaryColor),
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      // Start the app with the "/" named route. In this case, the app starts
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => LoginScreen(),
        '/login': (context) => LoginPage(),
        '/events': (context) => Events(),
        '/videos': (context) => Videos(),
        '/signup': (context) => SignupPage(),
        '/plans': (context) => PlansScreen(),
        '/profile': (context) => Profile(),
        '/free/member': (context) => FreePlan(),
        '/customize/plan': (context) => CustomizePlan(),
        '/premium/plan': (context) => PremiumPlan(),
        '/premium/payment': (context) => PremiumPlanPayment(),
        '/customizeplan/payment': (context) => CustomizePlanPayment(),
        '/new/feeds': (context) => Feeds(),
      },
    );
  }
}
