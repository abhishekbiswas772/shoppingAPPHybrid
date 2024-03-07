import 'package:bloc_example/Auth/AuthPresent/auth_forgot_password.dart';
import 'package:bloc_example/Auth/AuthPresent/auth_screen_login.dart';
import 'package:bloc_example/Auth/AuthPresent/auth_screen_signup.dart';
import 'package:bloc_example/Shopping/Details/product_details.dart';
import 'package:bloc_example/Shopping/Home/HomePresent/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const AuthScreenSignup());
      case "/signin":
        return MaterialPageRoute(builder: (_) => const AuthSignInScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => const ShoppingHome());
      case "/forgot":
        return MaterialPageRoute(builder: (_) => const AuthForgotScrren());
      case "/details":
        if (settings.arguments != null && settings.arguments is int) {
          int productId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => ProductDetails(productId: productId),
          );
        }else{
          return MaterialPageRoute(builder: (_) => const ShoppingHome());
        }
      default:
        return MaterialPageRoute(builder: (_) => const AuthScreenSignup());
    }
  }
}
