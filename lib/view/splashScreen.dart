import 'dart:async';
import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/controllers/auth.controller.dart';
import 'package:aponwola_admin/services/api.service.dart';
import 'package:aponwola_admin/testiing.dart';
import 'package:aponwola_admin/view/auth/login.view.dart';
import 'package:aponwola_admin/view/category/categoryList.view.dart';
import 'package:aponwola_admin/view/product/productList/productList.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  static const String id = "splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  String? initScreen = "1";

  final  authController=Get.put(AuthController());

  @override
  initState() {
    super.initState();
    moveOn();
  }

  moveOn() async {
    Timer(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      initScreen = prefs.getString("initScreen");
      await prefs.setString("initScreen", "1");
       authController.getAuth(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppTheme.whiteBackground,
            body: GestureDetector(
              onTap: () {
              },
              child: Center(
                child: Container(
                  width: MySize.size300,
                  height: MySize.size300,
                  decoration: const BoxDecoration(
                    image:  DecorationImage(
                        image: AssetImage(
                          'assets/apon.png',
                        ),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            )));
  }
}
