import 'package:flutter/material.dart';

class RegisterModel {
  String firstName;
  String lastName;
  String middleName;
  String occupation;
  String email;
  String userName;
  String phoneNumber;
  String password;
  String passwordConfirmation;
  String fullName;

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.occupation,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'middlename': middleName,
      'occupation': occupation,
      'username': userName,
      'phone_number': phoneNumber,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'fullname': fullName,
    };
  }
}
