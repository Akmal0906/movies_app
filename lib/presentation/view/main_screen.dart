import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/presentation/widgets/verify_email.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('data bor');
            print('${snapshot.data}');
            return const VerifyEmail();
          }
          {
            print('data yoq');

            return const SizedBox.shrink();

          }
        },
      ),
    );
  }
}
