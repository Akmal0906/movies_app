import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utilis/all_text.dart';
class CombainScreen extends StatelessWidget {
  const CombainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Combain Screen',style: customStyle.copyWith(fontSize: 26,color: Colors.black,letterSpacing: 1.5),),
            Text(user!.email.toString()),
            ElevatedButton(onPressed:(){
              FirebaseAuth.instance.signOut();
            }, child: Text('Sign out',style: customStyle,)),

          ],
        ),
      ),
    );
  }
}
