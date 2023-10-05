class UserModel {
  final String id;
  final String token;
  final String firstName;
  final String lastName;
  final String middleName;
  final String occupation;
  final String fullName;
  final String userName;
  final String phoneNumber;
  final String password;
  final String email;
  final String passwordConfirmation;
  final String role;
  final String smsPinId;

  UserModel(
      {required this.id,
      required this.token,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.occupation,
      required this.fullName,
      required this.userName,
      required this.phoneNumber,
      required this.password,
      required this.email,
      required this.passwordConfirmation,
      required this.role,
      required this.smsPinId});

  Map<String, dynamic> toJson() {
    return {
      'u_id': id,
      'token': token,
      'firstname': firstName,
      'lastname': lastName,
      'middlename': middleName,
      'occupation': occupation,
      'username': userName,
      'fullname': fullName,
      'phone_number': phoneNumber,
      'password': password,
      'email': email,
      'password_confirmation': passwordConfirmation,
      'sms_pinId': smsPinId,
    };
  }
}
