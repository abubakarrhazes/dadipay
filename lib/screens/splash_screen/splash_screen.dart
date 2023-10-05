import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dadipay_app/screens/logins/login.dart';
import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  bool isViewed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/logo512.png',
            width: 150,
            height: 150,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: Login(),
      splashIconSize: 200,
      splashTransition: SplashTransition.fadeTransition,
      duration: 8000,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
