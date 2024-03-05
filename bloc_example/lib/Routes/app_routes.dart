import 'package:bloc_example/Auth/AuthPresent/auth_forgot_password.dart';
import 'package:bloc_example/Auth/AuthPresent/auth_screen_login.dart';
import 'package:bloc_example/Auth/AuthPresent/auth_screen_signup.dart';
import 'package:bloc_example/Shopping/Home/home_screen.dart';
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
      default:
        return MaterialPageRoute(builder: (_) => const AuthScreenSignup());
    }
  }
}