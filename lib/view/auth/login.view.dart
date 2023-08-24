

import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/controllers/auth.controller.dart';
import 'package:aponwola_admin/custom_widget/btn.dart';
import 'package:aponwola_admin/custom_widget/txt.dart';
import 'package:aponwola_admin/util/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

final  authController=Get.put(AuthController());

 bool showPassword=false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor: Colors.white,
      body: GetX<AuthController>(
          builder: (authController) {
          return Stack(
            children: [
              Positioned(
                bottom: -350,
                left: -100,
                right:-100,
                child: Container(
                  height: MySize.size600,
                  width: MySize.size200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MySize.size100),
                    image:const  DecorationImage(
                      image: AssetImage(
                          'assets/foodie.png'),
                      fit: BoxFit.fill,
                    ),


                  ),

                ),
              ),


              loginFormWidget(context,authController ),
            ],
          );
        }
      ),
    );
  }

  Form loginFormWidget(BuildContext context,AuthController authController) {
    return Form(
          key: authController.loginKey.value,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(

              children: [

                SizedBox(height:MySize.size150),
                Row(
                  children: [
                    Text("Welcome back",style: TextStyle(fontSize: MySize.size40,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  children: [
                    Text("Enter you details",style: TextStyle(fontSize: MySize.size18),),
                  ],
                ),

                SizedBox(height:MySize.size30),

                MyText(
                  hintText: "Email",
                  controller: authController.emailController.value,
                  validator: Validator.emailValidator,
                ),

                MyText(
                  hintText: "Password",
                  controller: authController.passwordController.value,
                  validator: Validator.passwordValidator,
                  isPasswordField: showPassword,
                  suffixIcon: showPassword
                      ? const Icon(MdiIcons.eyeOutline)
                      : const Icon(MdiIcons.eyeOffOutline),
                  onSuffixItemTapped: () {
                    setState(() {
                      if (!showPassword){
                        showPassword = true;
                      }
                      else{
                        showPassword = false;
                      }
                    });
                  },
                ),
                authController.isLoading.value?
                const  Center(child:   CupertinoActivityIndicator()):
                MyButton(
                  text: "Sign-in",
                    // borderRadius: MySize.size10,
                    onPressed: (){
                      authController.logout(context);
                      if(authController.loginKey.value.currentState!.validate()){
                      authController.login(context);
                    }
                }),


                SizedBox(height:MySize.size20),



              ],
            ),
          ),
        );
  }
}
