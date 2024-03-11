import 'package:flutter/material.dart';

import '../../utilis/all_text.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int index;

  const MyTextField(
      {super.key,
      required this.size,
      required this.controller,
      required this.labelText,
      required this.index});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 6, right: 12, left: 12),
      width: size.width,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return TextFormField(
            obscureText: obscureList[index],
            controller: controller,
            decoration: InputDecoration(
                labelStyle: customStyle,
                suffixIcon: index == 3 || index == 2
                    ? IconButton(
                        icon: Icon(obscureList[index]
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            obscureList[index] = !obscureList[index];
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.green, width: 10),
                    borderRadius: BorderRadius.circular(12)),
                labelText: labelText,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Colors.amberAccent, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.blue.shade300, width: 1))),
          );
        },
      ),
    );
  }
}
