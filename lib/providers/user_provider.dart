// ignore_for_file: unused_field, prefer_final_fields

import 'package:dadipay_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
      id: '',
      token: '',
      firstName: '',
      lastName: '',
      middleName: '',
      occupation: '',
      fullName: '',
      userName: '',
      phoneNumber: '',
      password: '',
      email: '',
      passwordConfirmation: '',
      role: '',
      smsPinId: '');

  void get user => _user;

  void setUser() {
    _user.toJson();
    notifyListeners();
  }
}
