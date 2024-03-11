import 'package:flutter/material.dart';
import '../../utilis/all_text.dart';

elevatedButtonWidget(BuildContext context, void Function() onPressed, Size size,
    String text, Color color) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        minimumSize: size,
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(24)),
        )),
    onPressed: onPressed,
    child: Text(
      text,
      style: customStyle.copyWith(
          fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
    ),
  );
}
