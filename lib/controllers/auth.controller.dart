import 'package:aponwola_admin/common/constant.dart';
import 'package:aponwola_admin/routes/app.routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final key=GlobalKey<FormState>().obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var emailController=TextEditingController().obs;
  var passwordController=TextEditingController().obs;


 login(context)async{
   try {
     UserCredential userCredential = await auth.signInWithEmailAndPassword(
         email: emailController.value.text,
         password: passwordController.value.text
     );
     print("SUCCESS_LOG");

   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       print('No user found for that email.');
     } else if (e.code == 'wrong-password') {
       print('Wrong password provided for that user.');
     }
   }
 }


 register(context)async{
   try {
     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
         email: emailController.value.text,
         password: passwordController.value.text
     );
     print("SUCCESS_REG");
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
     }
   } catch (e) {
     print(e);
   }
 }

 getAuth(context)async{
   auth.authStateChanges()
       .listen((User? user) {
     if (user == null) {
       print('User is currently signed out!');

     } else {
       print('User is signed in!');
       print(user);
       Navigator.of(context)
           .pushNamedAndRemoveUntil(AppRoutes.ProductListViewRoute, (Route<dynamic> route) => false);

     }
   });
 }
}