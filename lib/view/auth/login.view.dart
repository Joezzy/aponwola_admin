

import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/controllers/auth.controller.dart';
import 'package:aponwola_admin/custom_widget/btn.dart';
import 'package:aponwola_admin/custom_widget/txt.dart';
import 'package:aponwola_admin/routes/app.routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

final  authController=Get.put(AuthController());


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.getAuth(context);

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: authController.key.value,
        child: Column(
          children: [
            SizedBox(height:MySize.size200),
            MyText(
              hintText: "Email",
              controller: authController.emailController.value,
            ),
            MyText(
              hintText: "Password",
              controller: authController.passwordController.value,
            ),

            MyButton(
              text: "Sign-in",
                onPressed: (){
                if(authController.key.value.currentState!.validate()){
                  authController.login(context);
                }

            }),
            SizedBox(height:MySize.size100),

            MyButton(
              text: "Sign-UP",
                onPressed: (){
                if(authController.key.value.currentState!.validate()){
                  authController.register(context);
                }

            }),


            TextButton(onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.RegisterRoute);
            }, child: Text("Dont have an account"))

          ],
        ),
      ),
    );
  }
}
