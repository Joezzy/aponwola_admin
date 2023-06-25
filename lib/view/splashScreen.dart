import 'dart:async';
import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/view/auth/login.view.dart';
import 'package:aponwola_admin/view/home/home.view.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';




// Step 1.
// String dropdownValue = 'Dog';
// Step 2.


class SplashScreen extends StatefulWidget {
  static const String id = "splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? initScreen = "1";


  @override
  initState() {
    super.initState();
    // Timer(Duration(seconds: 2), () => moveOn());

    Timer(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      initScreen = prefs.getString("initScreen");

      await prefs.setString("initScreen", "1");

      if (initScreen == "1") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              // builder: (BuildContext context) => FirstPrint()),
                builder: (BuildContext context) => HomeView()),
                (Route<dynamic> route) => false);
      } else {
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute( //original onboard
        //         builder: (BuildContext context) => OnBoardingScreen()),
        //         (Route<dynamic> route) => false);


      }
    });
  }


  moveOn() async {
    SharedPreferences crypt = await SharedPreferences.getInstance();
    String? access  =  crypt.getString("access");
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) =>OnBoardingScreen()),
    //         (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppTheme.o3Blue,
            body: GestureDetector(
              onTap: () {
              },
              child: Center(
                child: Container(
                  width: MySize.size100,
                  height: MySize.size100,
                  decoration: BoxDecoration(
                    image:  DecorationImage(
                        image: AssetImage(
                          'assets/logo_white.png',
                        ),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            )));
  }
}
