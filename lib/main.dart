import 'package:aponwola_admin/firebase_options.dart';
import 'package:aponwola_admin/testiing.dart';
import 'package:aponwola_admin/view/home.dart';
import 'package:aponwola_admin/view/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Aponwola admin' ,
      theme: ThemeData(
        primarySwatch:Colors.red,
      ),
      home: const MainHome(),

    );
  }
}

