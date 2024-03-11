import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/presentation/view/main/combain_screen.dart';
import 'package:movies_app/presentation/view/register/sign_in_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(snapshot.hasError){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        else if (snapshot.hasData) {
          return const CombainScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
