// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dadipay_app/routes/app_routes.dart';
import 'package:dadipay_app/screens/onboard/controller/onboard_controller.dart';
import 'package:dadipay_app/utils/error_handling.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/widgets/button_widget.dart';
import 'package:dadipay_app/widgets/onboard_content.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

final controller = OnboardController();
final AppRoutes appRoutes = AppRoutes();
int currentPageIndex = 0;
final pageController = PageController(initialPage: currentPageIndex);
final Color gray700 = Color(0xFF246EE9);

class _OnboardState extends State<Onboard> {
  late StreamSubscription subscription;
  var isConnected = false;
  bool isAlert = false;

  @override
  void dispose() {
    pageController.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  showConnectionDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlert = false);
                isConnected = await InternetConnectionChecker().hasConnection;
                if (!isConnected) {
                  showConnectionDialog(context, title, message);
                  setState(() {
                    isAlert = true;
                  });
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isConnected = await InternetConnectionChecker().hasConnection;
      if (!isConnected && isAlert == false) {
        showConnectionDialog(context, 'No Internet Connection',
            'Please Check Your Internet Connection');
        setState(() => isAlert = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, appRoutes.login);
            },
            child: Text(
              'Skip',
              style: TextStyle(
                  color: gray700, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: PageView.builder(
              itemCount: controller.screens.length,
              controller: pageController,
              onPageChanged: (int value) {
                setState(() {
                  currentPageIndex = value;
                });
              },
              itemBuilder: (_, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: OnboardContent(
                      image: controller.screens[index].imageAsset,
                      text: controller.screens[index].text,
                      desc: controller.screens[index].desc),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.screens.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    text: 'Next ',
                    onPress: () async {
                      if (currentPageIndex == 2) {
                        Navigator.pushNamed(context, appRoutes.login);
                      }
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceIn);
                    },
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 150),
      height: 6,
      width: currentPageIndex == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPageIndex == index ? KprimaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
