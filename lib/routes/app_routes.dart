import 'package:dadipay_app/screens/home_web_view.dart';
import 'package:dadipay_app/screens/logins/forgot_password/forgot_password.dart';
import 'package:dadipay_app/screens/logins/login.dart';

import 'package:dadipay_app/screens/logins/register/register.dart';
import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:dadipay_app/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

// Declare a global variable to store the user login token
String userLoginToken = '';

// Function to update the user login token
void updateUserLoginToken(String token) {
  userLoginToken = token;
}

class AppRoutes {
  String splash = '/';
  String onboard = 'onboard';
  String login = '/login';
  String register = '/register';
  String forgot = '/forgot';
  String verify = '/verify';
  String home = '/home';

  Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case 'onboard':
        return MaterialPageRoute(builder: (context) => Onboard());
      case '/register':
        return MaterialPageRoute(builder: (context) => Register());
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/forgot':
        return MaterialPageRoute(builder: (context) => ForgotPassword());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeWebView());

      default:
        throw ("Undefined Routes");
    }
  }
}
