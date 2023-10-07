import 'dart:convert';
import 'dart:async';

import 'package:dadipay_app/screens/logins/models/login_model.dart';
import 'package:dadipay_app/screens/onboard/onboard.dart';
import 'package:dadipay_app/utils/error_handling.dart';
import 'package:dadipay_app/utils/global_variables.dart';
import 'package:dadipay_app/utils/utils.dart';
import 'package:dadipay_app/widgets/button_widget.dart';
import 'package:dadipay_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

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

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final Color gray900 = Color(0xFF222222);
  final Color gray800 = Color(0xFF1D61D2);
  final Color gray700 = Color(0xFF246EE9);
  final Color gray600 = Color(0xFF020817);
  bool showError = false;

  final _login_formKey = GlobalKey<FormState>();

  String? userToken;
  http.Response? response;

  Future<void> Login(LogInModel user, BuildContext context) async {
    try {
      response = await http.post(Uri.parse('$baseUrl/login'),
          body: jsonEncode(user.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response!.statusCode == 200) {
        final responseData = json.decode(response!.body);
        final token = responseData['data']['token'] as String;
        setState(() {
          userToken = token;
        });
        print('Token : $userToken');
        utils.showSnackBar(context, 'User Login Succesfully');
        _navigateToWebView();
        // Return the user token
        print(' Responses Data: $responseData');
        //After Succesfull Request
      } else {
        final errorResponse = json.decode(response!.body)['message'];
        utils.showErrorDialog(context, 'Error', errorResponse);
        print(response!.statusCode);
        print(user.toJson());
      }
    } catch (e) {
      final errorResponse = json.decode(response!.body)['message'];
      utils.showToast(context, errorResponse);
    }
  }

  void _navigateToWebView() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WebViewPage(userToken: userToken),
    ));
  }

  void loginUser() {
    Login(
        LogInModel(
            email: emailController.text, password: passwordController.text),
        context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final locationStatus = await Permission.location.request();

    if (cameraStatus.isGranted && locationStatus.isGranted) {
      // Both camera and location permissions are granted
      // You can optionally perform additional actions here
    } else {
      // Either camera or location permission is not granted
      // Handle the case where permissions are not granted
      utils.showSnackBar(
          context, 'Please grant camera and location permissions.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: Container(
          decoration: BoxDecoration(
            boxShadow: showError
                ? [
                    BoxShadow(
                      color: gray800.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ]
                : [], // Apply the shadow conditionally
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logos.png',
                      height: 40,
                    ),
                    const SizedBox(height: 2),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 20),
                    Text('Login',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    const SizedBox(height: 20),
                    Card(
                        margin: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Theme(
                            data: ThemeData(primarySwatch: black),
                            child: Form(
                              key: _login_formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, top: 5, bottom: 5),
                                    child: Text('Email/Phone Number',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: gray600),
                                        )),
                                  ),
                                  const SizedBox(height: 5),
                                  MyInputField(
                                    controller: emailController,
                                    hintText: 'Email',
                                    prefixIcon: Icon(
                                        Icons.mail_outline_outlined,
                                        color: gray700),
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
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, top: 5, bottom: 5),
                                    child: Text('Password',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: gray600),
                                        )),
                                  ),
                                  MyInputField(
                                    controller: passwordController,
                                    hintText: 'Password',
                                    isPassword: true,
                                    prefixIcon: Icon(
                                      Icons.lock_outline_sharp,
                                      color: gray700,
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field cant be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 8),
                                    child: ButtonWidget(
                                      onPress: () async {
                                        if (_login_formKey.currentState!
                                            .validate()) {
                                          loginUser();
                                        }
                                      },
                                      text: 'Login',
                                    ),
                                  )
                                ],
                              ),
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24, bottom: 16, left: 8, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, appRoutes.forgot);
                            },
                            child: Text(
                              'Reset Password',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: KprimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text('Don\'t have an account? ',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, appRoutes.register);
                                },
                                child: Text(
                                  'Create account',
                                  style: TextStyle(
                                      color: KprimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String? userToken;

  WebViewPage({required this.userToken});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _webViewController;

  double _progress = 0;
  late Timer _tokenCheckTimer;

  @override
  void initState() {
    super.initState();

    // Start a timer to periodically check the token's validity
    _tokenCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      // Check if the token is still valid by making a request to the backend
      checkTokenValidity();
    });
  }

  @override
  void dispose() {
    _tokenCheckTimer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

/*   Future<void> checkTokenValidity(String userToken) async {
  try { 
    final response = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    if (response.statusCode == 200) {
       final responseData = json.decode(response.body);
       final isValid = responseData['isValid'];
       
        if (!isValid) {
          // Token is no longer valid, navigate to the login page
          Navigator.of(context).pushReplacementNamed(appRoutes.login);
        }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
        Navigator.pushReplacementNamed(context, appRoutes.login);
    } else {
          // Token is no longer valid, close WebView and navigate to login page
          window.flutter_inappwebview.callHandler('closeWebView'); // Close WebView
          window.flutter_inappwebview.callHandler('navigateToLogin'); // Navigate to login page
    }
  } catch (e) {
     // Handle any exceptions or network errors here.
    print('Error checking token validity: $e');
  }
}
 */

//  in DART js code is put inside a triple string ,check the index.html for more details
  void checkTokenValidity() {
    final script = '''
    // JavaScript code to check token validity (example)

    // Define a function to check token validity
    function checkToken() {
      //  HTTP request to check token validity
      fetch('$baseUrl/me', {
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${widget.userToken}'
           },
       })
      .then(response => {
        if (response.status === 200) {
          // Token is still valid
        } else {
          // Token is no longer valid, close WebView and navigate to login page
          window.flutter_inappwebview.callHandler('closeWebView'); // Close WebView
          window.flutter_inappwebview.callHandler('navigateToLogin'); // Navigate to login page
        }
      })
      .catch(error => {
        // Handle any errors here
        console.error('Error checking token validity: ' + error);
      });
    }


    // Periodically check token validity (adjust the interval as needed)
    setInterval(checkToken, 5000); // Check every 5 seconds (example)
  ''';

    // Inject the JavaScript code into the WebView
    _webViewController?.evaluateJavascript(source: script);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse(
                'https://app.dadipay.co/android.php?login_token=${widget.userToken}',
              ),
              headers: {
                'Accept': 'application/vnd.api+json',
                'Content-Type': 'application/json',
              }),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
        ),
      ),
    );
  }
}
