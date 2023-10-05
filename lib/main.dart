// ignore_for_file: prefer_const_constructors

import 'package:dadipay_app/routes/app_routes.dart';
import 'package:dadipay_app/screens/home_web_view.dart';
import 'package:dadipay_app/screens/logins/forgot_password/forgot_password.dart';
import 'package:dadipay_app/screens/logins/register/register.dart';

import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

bool isViewed = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getBool('isViewed') ?? false;
  await preferences.setBool('isViewed', true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  final AppRoutes appRoutes = AppRoutes();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dadipay_app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: KprimaryColor,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: KprimaryColor),
        ),
        onGenerateRoute: appRoutes.controller,
        initialRoute: appRoutes.splash
        // isViewed == false ? appRoutes.onboard : appRoutes.login
        );
  }
}
