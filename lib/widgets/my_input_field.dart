// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dadipay_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInputField extends StatefulWidget {
  const MyInputField(
      {Key? key,
      this.isPassword = false,
      this.hintText,
      this.keyboardType,
      this.validator,
      this.onSaved,
      this.prefixIcon,
      this.label,
      this.controller})
      : super(key: key);

  final bool isPassword;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final String? label;

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  bool visiblePassword = false;
  final Color gray700 = Color(0xFF246EE9);

  @override
  void initState() {
    super.initState();
    visiblePassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: visiblePassword,
      autocorrect: !widget.isPassword,
      enableSuggestions: !widget.isPassword,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onSaved: widget.onSaved,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15),
      ),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              )),
          prefixIcon: widget.prefixIcon,
          labelText: widget.label,
          fillColor: gray700,
          suffixIcon: widget.isPassword == false
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      visiblePassword = !visiblePassword;
                    });
                  },
                  icon: Icon(visiblePassword
                      ? Icons.visibility
                      : Icons.visibility_off))),
    );
  }
}
