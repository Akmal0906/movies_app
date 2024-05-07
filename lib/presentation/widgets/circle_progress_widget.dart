import 'package:flutter/material.dart';
class CircleProgressWidget extends StatelessWidget {
  const CircleProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white70,
        backgroundColor: Colors.indigo.shade900,
      ),
    );
  }
}
