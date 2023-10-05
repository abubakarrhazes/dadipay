// ignore_for_file: unused_field

import 'package:dadipay_app/screens/logins/forgot_password/models/forgot_password_model.dart';
import 'package:dadipay_app/serviices/api_client.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/utils/utils.dart';
import 'package:dadipay_app/widgets/button_widget.dart';
import 'package:dadipay_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _resetPassword_key = GlobalKey<FormState>();

  final TextEditingController _resetPasswordController =
      TextEditingController();

  final ApiClient apiClient = ApiClient();
  final Utils utils = Utils();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resetPasswordController.dispose();
    super.dispose();
  }

  void ForgotPassword() {
    apiClient.ForgotPassword(
        ForgotPasswordModel(phoneNumber: _resetPasswordController.text),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: KprimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Image.asset(
              'assets/images/pass.png',
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Reset Password',
              style: TextStyle(
                  color: KprimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _resetPassword_key,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    MyInputField(
                      controller: _resetPasswordController,
                      hintText: 'Enter Your Phone Number Here',
                      label: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonWidget(
                        text: 'Send OTP',
                        onPress: () async {
                          if (_resetPassword_key.currentState!.validate()) {
                            ForgotPassword();
                          }
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
