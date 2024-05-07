import 'package:flutter/material.dart';
IconButton buildIconButton(BuildContext context) {
  return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_outlined,
        color: Colors.white,
        size: 21,
      ));
}
