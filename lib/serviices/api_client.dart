// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dadipay_app/models/user_model.dart';
import 'package:dadipay_app/providers/user_provider.dart';
import 'package:dadipay_app/routes/app_routes.dart';
import 'package:dadipay_app/screens/home_web_view.dart';
import 'package:dadipay_app/screens/logins/forgot_password/models/forgot_password_model.dart';
import 'package:dadipay_app/screens/logins/models/login_model.dart';
import 'package:dadipay_app/screens/logins/register/model/register_model.dart';
import 'package:dadipay_app/screens/logins/register/register.dart';
import 'package:dadipay_app/utils/error_handling.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  //Route API For Registration

  final AppRoutes appRoutes = AppRoutes();

  Future<void> ForgotPassword(
      ForgotPasswordModel user, BuildContext context) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$baseUrl/forgetpassword'),
          body: jsonEncode(user.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(' OTP Sent  successful: $responseData');
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              utils.showSnackBar(context, 'OTP Sent Succesfully');
            });
      } else {
        final responseData = json.decode(response.body)['message'];
        print(response.body);
        print(response.statusCode);
        utils.showSnackBar(context, json.decode('$responseData'));
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {}
  }
}
