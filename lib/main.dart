import 'package:aponwola_admin/routes/app.routes.dart';
import 'package:aponwola_admin/view/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aponwola Admin',
      // theme: ThemeData.dark(),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      initialRoute: AppRoutes.SplashRoute,
      routes: AppRoutes.routes,
    );
  }
}

