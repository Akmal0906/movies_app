import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/data/hive_box/local_storage.dart';
import 'package:movies_app/presentation/view/register/sign_in_screen.dart';
import 'package:movies_app/utilis/all_text.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData &&
              (userData.isEmpty ||
                  (userData.get('email') == userNameController.text.trim() &&
                      userData.get('password') == emailController.text.trim()))) {





            WidgetsBinding.instance.addPostFrameCallback((_) {
              userData.put('email', userNameController.text.trim());
              userData.put('password', emailController.text.trim());
              userNameController.clear();
              emailController.clear();
              context.goNamed('combain');
            });

          } else {

            WidgetsBinding.instance.addPostFrameCallback((_) {
              userNameController.clear();
              emailController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please check email or passw'),
                duration: Duration(seconds: 2),
              ));
            });
            return SignInScreen();


          }

          return SignInScreen();
        },
      )
    ;
  }
}
