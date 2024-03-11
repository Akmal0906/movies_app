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

}

TextStyle customStyle =
    const TextStyle(color: Colors.black, fontFamily: 'Rubik', fontSize: 14);

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
