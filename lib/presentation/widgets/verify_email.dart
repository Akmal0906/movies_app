import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerification();
      timer=Timer.periodic(const Duration(seconds: 3), (timer) =>checkEmail());
    }
  }

  sendVerification()async{
    try{
      print('Verify page send verification working');
      final user=FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    }catch(e){
      print('Verify page send verification exception $e');

    }

  }
  checkEmail()async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified) {
      print('email vireidied');
    } else {
      print('Else working');
      return SizedBox.shrink();
    }
    return SizedBox.shrink();
  }
}
