// ignore_for_file: unused_element

import 'package:dadipay_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class Utils {
  final AppRoutes appRoutes = AppRoutes();
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  //ShowError Dialog
  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void viewShowDialog(BuildContext context, String message,
      {bool isSuccess = true}) {
    Color dialogBackgroundColor = isSuccess ? Colors.green : Colors.red;
    Color titleColor = Colors.white;
    Color contentColor = Colors.black;
    Color buttonTextColor = Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            isSuccess ? 'Success' : 'Error',
            style: TextStyle(color: titleColor),
          ),
          content: Text(
            message,
            style: TextStyle(color: contentColor),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, appRoutes.verify);
              },
              child: Text(
                'OK',
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
