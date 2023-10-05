import 'package:dadipay_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dadipay_app/serviices/api_client.dart';

class HomeWebView extends StatefulWidget {
  const HomeWebView({super.key});

  @override
  State<HomeWebView> createState() => _HomeWebViewState();
}

class _HomeWebViewState extends State<HomeWebView> {
  //initialised the webview Controller
  InAppWebViewController? _webViewController;
  double _progress = 0;
  final ApiClient apiClient = ApiClient();

  // Declare a global variable to store the user login token
  String userLoginToken = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse(
                'https://app.dadipay.co/android.php?login_token$userLoginToken',
              ),
              headers: {
                'Accept': 'application/vnd.api+json',
                'Content-Type': 'application/json',
              }),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
        ),
      ),
    );
  }
}
