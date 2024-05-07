import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/widgets/elevated_button_widget.dart';
import 'package:movies_app/presentation/widgets/my_textfield_widget.dart';
import 'package:movies_app/presentation/widgets/top_widget.dart';
import '../../../utilis/all_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const SizedBox(
              height: 76,
            ),
            TopWidget(size: size),
            Text(
              AllText.createText,
              style: customStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 26,
            ),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return MyTextField(
                    size: size,
                    controller: controllerList[index],
                    labelText:
                        index == 0 ? labelTextList[index+1] : labelTextList[2],
                    index: index);
              },
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                elevatedButtonWidget(context, () {
                  signin(context, userNameController.text.trim(),
                      emailController.text.trim());
                }, Size(size.width - 50, 46), 'Sign In', Colors.grey.shade400),
                const SizedBox(
                  height: 24,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                              color: Colors.blueAccent, fontSize: 18),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(context).pushNamed('signup');
                            }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

signin(BuildContext context, String email, String password) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return const Center(
            child: CircularProgressIndicator(),
          );});
  try {
    if (email.endsWith('@gmail.com')) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        GoRouter.of(context).pushReplacementNamed('mainpage');



      }).onError((error, stackTrace) {
          userNameController.clear();
          emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong'),duration: Duration(seconds: 2),));
      });
    } else {
      print(false);
      userNameController.clear();
      emailController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please check email'),
        duration: Duration(seconds: 2),
      ));
    }
  }  catch (error) {



  }

}
