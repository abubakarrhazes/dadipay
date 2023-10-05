import 'package:dadipay_app/screens/onboard/model/onboard_model.dart';

class OnboardController {
  List<OnboardModel> screens = [
    OnboardModel(
        'assets/images/logo.jpeg',
        'Welcome to Your Dadipay Wallet Adventure! ',
        'Let Secure, Spend, and Save Together'),
    OnboardModel('assets/images/image.jpeg', 'Secure Funds',
        'Discover a world of financial convenience at your fingertips. With Dadipay, managing your money has never been easier.'),
    OnboardModel('assets/images/logo.jpeg', 'Track Your Finances',
        ' Get insights into your spending habits and savings goals.'),
  ];
}
