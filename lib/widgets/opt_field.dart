// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatefulWidget {
  const OtpField({required this.controller});

  final TextEditingController controller;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

final TextEditingController otpController = TextEditingController();

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: SizedBox(
      height: 68,
      width: 150,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
        ],
      ),
    ));
  }
}
