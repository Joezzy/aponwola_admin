
import 'package:aponwola_admin/view/auth/login.view.dart';
import 'package:aponwola_admin/view/auth/register.view.dart';
import 'package:aponwola_admin/view/product/productList.view.dart';
import 'package:aponwola_admin/view/splashScreen.dart';

class AppRoutes{
  static const String LoginRoute="/login";
  static const String SplashRoute="/";
  static const String RegisterRoute="/register";
  static const String ProductListViewRoute="/login/ProductList";

  static final routes={
    SplashRoute:(context)=>SplashScreen(),
    LoginRoute:(context)=>LoginView(),
    RegisterRoute:(context)=>RegisterView(),
    ProductListViewRoute:(context)=>ProductListView(),
  };
}