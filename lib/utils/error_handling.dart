import 'dart:convert';

import 'package:dadipay_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final Utils utils = Utils();

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      utils.showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      utils.showSnackBar(context, jsonDecode(response.body)['msg']);
    default:
      utils.viewShowDialog(context, response.body);
  }
}
