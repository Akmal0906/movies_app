import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/view/register/sign_up_screen.dart';
import 'package:movies_app/presentation/widgets/verify_email.dart';

import '../../utilis/all_text.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (isTrue) async{
        WidgetsBinding.instance.addPostFrameCallback((_) {

          emailController.clear();
          passwordController.clear();
          userNameController.clear();
          confirmPassword.clear();
          context.pop();



        });
      },
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('${snapshot.data}');
              return const VerifyEmail();
            }
            {

              return const SignUpScreen();

            }
          },
        ),
      ),
    );
  }
}
