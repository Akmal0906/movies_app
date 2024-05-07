import 'package:flutter/material.dart';
import 'package:movies_app/utilis/all_colors.dart';
import 'package:movies_app/utilis/all_text.dart';

class RoutErrorScreen extends StatelessWidget {
  const RoutErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.primaryBackColor,
      body: Center(
        child: Text(
          'Did not found page',
          style: customStyle.copyWith(fontSize: 17),
        ),
      ),
    );
  }
}
