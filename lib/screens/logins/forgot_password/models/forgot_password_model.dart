class ForgotPasswordModel {
  String phoneNumber;

  ForgotPasswordModel({required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {'phone_number': phoneNumber};
  }
}
