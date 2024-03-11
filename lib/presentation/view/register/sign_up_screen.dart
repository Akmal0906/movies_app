import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/utilis/all_text.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/my_textfield_widget.dart';
import '../../widgets/top_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            TopWidget(size: size),
            Text(
              AllText.loginText,
              style: customStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controllerList.length,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return MyTextField(
                    size: size,
                    controller: controllerList[index],
                    labelText: labelTextList[index],
                    index: index,
                  );
                },
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                elevatedButtonWidget(context, () {
                  signup(emailController.text.trim(), passwordController.text.trim(),context);
                }, Size(size.width - 50, 46),
                    'Sign up', Colors.grey.shade400),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 6, left: 20, right: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(width: 1, color: Colors.grey.shade600),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/google.svg',
                              fit: BoxFit.cover,
                              height: 29,
                              width: 29,
                            ),
                            const SizedBox(
                              width: 11,
                            ),
                            Text(
                              'Google',
                              style: customStyle.copyWith(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 6, left: 20, right: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(width: 1, color: Colors.grey.shade600),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/facebook.svg',
                              fit: BoxFit.cover,
                              height: 29,
                              width: 29,
                            ),
                            const SizedBox(
                              width: 11,
                            ),
                            Text(
                              'Facebook',
                              style: customStyle.copyWith(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: AllText.haveAccount,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Sign in',
                          style: const TextStyle(
                              color: Colors.blueAccent, fontSize: 18),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(context).pushNamed('signin');
                            }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

void signup(String email, String password,BuildContext context) {
  try {
    print('try working');
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password).then((value) => print('Value ${value.additionalUserInfo}'));
  } on FirebaseAuthException catch (e) {
    print('FirebaseException $e');
  }

  GoRouter.of(context).pushReplacementNamed('main');
}
