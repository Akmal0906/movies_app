import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AllText {
  static const String welcome = 'Welcome to App';
  static const String introduce =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptates porro reprehenderit iusto suscipit aperiam.';
  static const String started = 'Get Started';
  static const String loginText = 'Login to your Account';
  static const String createText = 'Create your Account';
  static const String haveNotAccount = 'Don’t have an account?';
  static const String haveAccount = 'Already have an account!';


  static const String popular = 'Popular';
  static const String trending = 'Trending';
  static const String coomingSoon = 'CoomingSoon';
  static const String ongiong = 'Ongiong';
  static const String seeAll = 'See all';
  static const String category='Category';

  static const String kinoPlay='KinoPlay';

  static const String clearAll='Clear All';
  static const String clearSelect='Clear Select';
  static const String cancel='Cancel';
  static const String didnotAdd='Did not add yet';

  static const String notifTextBottomSheet='Are you sure want to delete all';
  static const String confirm='Confirm';


}

TextStyle customStyle =
    const TextStyle(color: Colors.white, fontFamily: 'Rubik', fontSize: 14);

final TextEditingController userNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPassword = TextEditingController();
final List<TextEditingController> controllerList = [
  userNameController,
  emailController,
  passwordController,
  confirmPassword
];
final List<String> labelTextList = [
  'Username',
  'Email',
  'Password',
  'Confirm Password'
];
List<bool> obscureList = [false, false, false, false];


List<String> titleList=['Horror','Dramma','Military','Fantasy','Comedy','Action','Detectives'];
