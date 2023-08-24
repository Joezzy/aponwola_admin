import 'package:aponwola_admin/common/myDialog.dart';
import 'package:aponwola_admin/services/api.service.dart';
import 'package:aponwola_admin/util/authHandler.dart';
import 'package:aponwola_admin/view/auth/login.view.dart';
import 'package:aponwola_admin/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  final loginKey=GlobalKey<FormState>().obs;
  final registerKey=GlobalKey<FormState>().obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var nameController=TextEditingController().obs;
  var emailController=TextEditingController().obs;
  var passwordController=TextEditingController().obs;
  var phoneController=TextEditingController().obs;
  var isLoading=true.obs;
 var avatar="".obs;
 late  Rx<Uint8List> image;

  login(context)async{
   isLoading.value=true;
   try {
     UserCredential userCredential = await auth.signInWithEmailAndPassword(
         email: emailController.value.text,
         password: passwordController.value.text
     );
     isLoading.value=false;
   }  on FirebaseAuthException catch (e) {
     isLoading.value=false;
     String message=   AuthExceptionHandler.handleAuthException(e);
     Dialogs.alertBox(context, "Unsuccessful", message, DialogType.error);
   }
 }


  // login2(context)async{
  //   try {
  //     auth.signInWithEmailAndPassword(
  //         email: emailController.value.text,
  //         password: passwordController.value.text
  //     ).then((user) async {
  //       if (user != null) {
  //         log('\nUser: ${user.user}');
  //         log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
  //         if ((await ApiService.userExists())) {
  //           Navigator.pushReplacement(
  //               context, MaterialPageRoute(builder: (_) =>  HomeView()));
  //         } else {
  //
  //           print("Failedd");
  //         }
  //       }
  //     });
  //
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

 // register2(context)async{
 //   try {
 //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
 //         email: emailController.value.text,
 //         password: passwordController.value.text
 //     );
 //     print("SUCCESS_REG");
 //   } on FirebaseAuthException catch (e) {
 //     if (e.code == 'weak-password') {
 //       print('The password provided is too weak.');
 //     } else if (e.code == 'email-already-in-use') {
 //       print('The account already exists for that email.');
 //     }
 //   } catch (e) {
 //     print(e);
 //   }
 // }


  register(context)async {
    isLoading.value=true;

    var image = "";
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text
      ).then((user) async {
        // Navigator.pop(context);
        if (user != null) {
          await ApiService.createUser(
              emailController.value.text,
              nameController.value.text
          ).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainHome()));
          });
        }

      });
      isLoading.value=false;

      print("SUCCESS_REG");
    } on FirebaseAuthException catch (e) {

      isLoading.value=false;
   String message=   AuthExceptionHandler.handleAuthException(e);
      Dialogs.alertBox(
          context, "Unsuccessful", message,
          DialogType.error);
    } catch (e) {
      isLoading.value=false;
      Dialogs.alertBox(context, "Unsuccessful", e.toString(), DialogType.error);
    }
  }

  updateProfile(context,img)async {
    isLoading.value=true;
    var image = "";
    if(img!=null){
      await ApiService.updateProfilePicture(img);
    }

    try {
      await ApiService.updateUserInfo(
          nameController.value.text,
        phoneController.value.text,
      ).then((value)async {
        ApiService.me = await ApiService.getSelfInfo();
        loadProfile();
        Dialogs.alertBox(
            context, "Successful", "Profile updated",
            DialogType.success);
      });
      isLoading.value=false;
      print("SUCCESS_REG");
    } on FirebaseAuthException catch (e) {
      isLoading.value=false;
   String message=   AuthExceptionHandler.handleAuthException(e);
      Dialogs.alertBox(
          context, "Unsuccessful", message,
          DialogType.error);
    } catch (e) {
      isLoading.value=false;
      Dialogs.alertBox(context, "Unsuccessful", e.toString(), DialogType.error);
    }
  }

  getAuth(context)async{
    isLoading.value=true;
   try {
     auth.authStateChanges()
         .listen((User? user) async {
       if (user != null) {
         print('User is signed in!');
         print(user);
         ApiService.me = await ApiService.getSelfInfo();
         print("USER_DETAIl");
         print(ApiService.me.email);
         print(ApiService.me.name);
         print(ApiService.me.id);
         // DashboardScreen

         //
         Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(
                 builder: (BuildContext context) => LoginView()),
             // builder: (BuildContext context) =>  ProductListView()),
                 (Route<dynamic> route) => false);
       }else{
         Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(
                 builder: (BuildContext context) =>const  MainHome()),
                 (Route<dynamic> route) => false);
       }
     });
     isLoading.value=false;
   }on FirebaseAuthException catch (e) {
     isLoading.value=false;
     String message=   AuthExceptionHandler.handleAuthException(e);
     // Dialogs.alertBox(
     //     context, "Unsuccessful", message,
     //     DialogType.error);
   } catch(e){
     isLoading.value=false;
     // Dialogs.alertBox(context, "Unsuccessful", e.toString(), DialogType.error);
    }
 }


 loadProfile()async{
   print("PRO_FILE");
    nameController.value.text=ApiService.me.name.toString();
    phoneController.value.text=ApiService.me.phone.toString();
   avatar.value=ApiService.me.image!;
 }


 logout(context)async{
   isLoading.value=true;
   await  auth.signOut();
   Navigator.of(context).pushAndRemoveUntil(
       MaterialPageRoute(
           builder: (BuildContext context) => LoginView()),
           (Route<dynamic> route) => false);


   isLoading.value=false;
 }
}