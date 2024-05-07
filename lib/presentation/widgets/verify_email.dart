import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/data/hive_box/local_storage.dart';
import 'package:movies_app/utilis/all_colors.dart';
import 'package:movies_app/utilis/all_text.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late bool isEmailVerified;
   Timer timer=Timer(const Duration(seconds: 2), () { });

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerification();
      timer =
          Timer.periodic(const Duration(seconds: 3), (timer) => checkEmail());
    }
  }


  sendVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } catch (e) {
    }
  }

  checkEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    });
  }

  @override
  void dispose() {
    timer.cancel();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPassword.clear();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    direction();
    return Scaffold(
      backgroundColor: AllColors.primaryBackColor,
      key: _scaffoldKey,
      body: Center(
        child: Text('We sent request to email for confirm. Email verify $isEmailVerified',
          style: customStyle.copyWith(
              fontWeight: FontWeight.w400, fontSize: 21),),
      ),

    );
  }

  void direction() {
    if (isEmailVerified) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        userData.put('email', FirebaseAuth.instance.currentUser!.email);
        userData.put('password', passwordController.text.trim());
        userData.put('name', userNameController.text.trim());

        emailController.clear();
        passwordController.clear();

        context.goNamed('combain');

      });
    }
  }
}
