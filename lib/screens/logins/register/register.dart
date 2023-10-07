// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:dadipay_app/models/user_model.dart';
import 'package:dadipay_app/routes/app_routes.dart';
import 'package:dadipay_app/screens/logins/register/model/register_model.dart';
import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:dadipay_app/serviices/api_client.dart';
import 'package:dadipay_app/utils/error_handling.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/widgets/button_widget.dart';
import 'package:dadipay_app/widgets/my_input_field.dart';
import 'package:dadipay_app/widgets/opt_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

const MaterialColor black = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFFEEEEEE),
    100: Color(0xFFBBBBBB),
    200: Color(0xFF999999),
    300: Color(0xFF555555),
    400: Color(0xFF333333),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _register_formKey = GlobalKey<FormState>();
  String? sms_pin_id;
  String? u_id;
  String? phone_number;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final ApiClient apiClient = ApiClient();
  final AppRoutes appRoutes = AppRoutes();
  final formResult = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    middleNameController.dispose();
    occupationController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  http.Response? response;

  Future<void> Register(RegisterModel user, BuildContext context) async {
    try {
      UserModel userModel = UserModel(
        id: '',
        token: '',
        smsPinId: '',
        role: '',
        firstName: user.firstName,
        lastName: user.lastName,
        middleName: user.middleName,
        occupation: user.occupation,
        userName: user.userName,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        password: user.password,
        email: user.email,
        passwordConfirmation: user.passwordConfirmation,
      );
      response = await http.post(Uri.parse('$baseUrl/register'),
          body: jsonEncode(userModel.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response!.statusCode == 200) {
        final responseData = json.decode(response!.body);
        final sms_pin = responseData['data']['user']['sms_pinId'] as String;
        final id = responseData['data']['user']['u_id'] as String;
        final phone = responseData['data']['user']['phone_number'] as String;
        print(sms_pin_id);
        print(u_id);
        print(phone);
        setState(() {
          sms_pin_id = sms_pin;
          u_id = id;
          phone_number = phone;
        });
        print(' Registered successful: $responseData');
        print('Sms_Pin : $sms_pin_id');
        print('User Id : $u_id');
        print('Phone $phone_number');
        _navigateToVerifyOtp();
      } else {
        print(user.toJson());
      }
    } catch (e) {
      final errorResponse = json.decode(response!.body)['message'];
      utils.showToast(context, errorResponse);
    }
  }

  void _navigateToVerifyOtp() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => VerifyOTP(
        sms_pin_id: sms_pin_id as String,
        u_id: u_id as String,
        phone_number: phone_number as String,
      ),
    ));
  }

  void registerUser() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    Register(
        RegisterModel(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            middleName: middleNameController.text,
            occupation: occupationController.text,
            fullName: fullNameController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            userName: userNameController.text,
            password: passwordController.text,
            passwordConfirmation: passwordConfirmationController.text),
        context);

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Theme(
                    data: ThemeData(primarySwatch: black),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/logos.png',
                            height: 40,
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Text('Create An Account',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              )),
                          const SizedBox(height: 18),
                          Form(
                            key: _register_formKey,
                            child: Column(
                              children: [
                                MyInputField(
                                  controller: firstNameController,
                                  hintText: 'Firstname',
                                  label: 'Firstname',
                                  prefixIcon: Icon(Icons.person_2_outlined,
                                      color: KprimaryColor),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: lastNameController,
                                  label: 'Lastname',
                                  hintText: 'Lastname',
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: middleNameController,
                                  label: 'Middlename',
                                  hintText: 'Middlename',
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: occupationController,
                                  label: 'Occupation',
                                  hintText: 'Occupation',
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: fullNameController,
                                  label: 'Fullname',
                                  hintText: 'Fullname',
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: emailController,
                                  label: 'Email',
                                  hintText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.mail_outline_outlined,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    RegExp emailRegExp = RegExp(
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                                    if (value == null || value.isEmpty) {
                                      return 'Email can\'t be empty';
                                    } else if (!emailRegExp.hasMatch(value)) {
                                      return 'Enter a correct email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: phoneNumberController,
                                  label: 'Phone Number',
                                  hintText: ' Enter Phone Number',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: userNameController,
                                  label: 'Username',
                                  hintText: 'Unique Username',
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MyInputField(
                                  controller: passwordController,
                                  label: 'Password',
                                  hintText: ' Create a Strong Password',
                                  isPassword: true,
                                  prefixIcon: Icon(
                                    Icons.lock_outline_sharp,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                MyInputField(
                                  controller: passwordConfirmationController,
                                  label: 'Confirm Password',
                                  hintText: ' Confirm Password',
                                  isPassword: true,
                                  prefixIcon: Icon(
                                    Icons.lock_outline_sharp,
                                    color: KprimaryColor,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field cant be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                ButtonWidget(
                                  onPress: () {
                                    if (_register_formKey.currentState!
                                        .validate()) {
                                      registerUser();
                                    }
                                  },
                                  text: 'Register',
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, bottom: 16, left: 8, right: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already  have an account? ',
                            style: GoogleFonts.poppins(textStyle: TextStyle()),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, appRoutes.login);
                              },
                              child: Text(
                                'Login Here',
                                style: GoogleFonts.poppins(
                                    textStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: KprimaryColor,
                                      fontWeight: FontWeight.bold),
                                )),
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerifyOTP extends StatefulWidget {
  String sms_pin_id;
  String u_id;
  String phone_number;
  VerifyOTP({
    required this.sms_pin_id,
    required this.u_id,
    required this.phone_number,
  });

  @override
  State<VerifyOTP> createState() => _VeriryOTPState();
}

final TextEditingController otpController = TextEditingController();
String? otppin;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
int _resendCountDown = 0;
Timer? _resendTimer;

@override
class _VeriryOTPState extends State<VerifyOTP> {
  @override
  void initState() {
    super.initState();
    // Start the resend cooldown timer when the screen initializes.
    startResendCooldown();
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks.
    _resendTimer?.cancel();
    super.dispose();
  }

  void startResendCooldown() {
    // Start a 5-minute countdown timer.
    const int countDownDurationInSeconds = 5 * 60;
    _resendCountDown = countDownDurationInSeconds;

    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _resendCountDown--;

        if (_resendCountDown == 0) {
          // The cooldown period is over; you can now allow the user to resend OTP.
          timer.cancel();
        }
      });
    });
  }

  void showErrorDialog(String title, String message) {
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

  Future<void> sendUserOtp() async {
    //final String otprefpin = '$userId-$timestamp';
    final String enteredOtp = otppin as String;

    try {
      final url =
          '$baseOtpUrl/api/verifyotp/${widget.sms_pin_id}/$enteredOtp/${widget.u_id}/user';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        bool isVerified = responseData['verified'];
        if (isVerified == true) {
          Navigator.of(context).pushReplacementNamed(appRoutes.login);
          print('Verified Successfully');
        } else {
          showErrorDialog('Verification Failed', 'An Error Occur');
        }
      } else {
        showErrorDialog('Server Error',
            'An error occurred while verifying the OTP. Please try again.');
        print(url);
      }
    } catch (e) {
      showErrorDialog('Error',
          'An error occurred. Please check your internet connection and try again.');
    }
  }

  Future<void> resendOtp() async {
    bool dndMode = true;
    if (_resendCountDown == 0) {
      try {
        final url =
            '$baseOtpUrl/api/sendotpmobile/${widget.phone_number}/$dndMode';
        http.Response response = await http.get(Uri.parse(url), headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final otpStatus = responseData['status'];
          if (otpStatus == 200) {
            utils.showErrorDialog(
                context, 'OTP Resend Successfully', 'Kindly Check Your Inbox');
          }
        } else {
          showErrorDialog(
              'OTP Resent Failure', 'Resent Otp not Send Due Server Failure');
        }
        print(url);
      } catch (e) {
        showErrorDialog('', 'Failed');
      }
      startResendCooldown();
    } else {
      showErrorDialog(
        'Resend OTP',
        'Please wait ${_resendCountDown ~/ 60}:${(_resendCountDown % 60).toString().padLeft(2, '0')} before requesting a new OTP.',
      );
    }
  }

  void userOtp() {
    setState(() {
      String entered = otpController.text;
      otppin = entered;
      print(" You Entered $otppin");
      print('Msn pid ${widget.sms_pin_id}');
      print('User Id ${widget.u_id}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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
            Text(
              'Verification Code ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: Text(
                'Your Verification Code OTP has been sent ${widget.phone_number}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpField(
                    controller: otpController,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                resendOtp();
              },
              child: Text(
                'Resend Otp',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ButtonWidget(
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  userOtp();
                  sendUserOtp();
                }
              },
              text: 'Verify OTP',
            )
          ],
        ),
      ),
    ));
  }
}
