import 'package:dadipay_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPress;
  bool isLoading = false;
  final Color gray800 = Color(0xFF1D61D2);
  ButtonWidget({required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          color: gray800,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(text,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              )),
        ),
      ),
    );
  }
}
