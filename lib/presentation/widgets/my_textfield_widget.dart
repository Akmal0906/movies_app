
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utilis/all_text.dart';
import '../blocs/search_movie_bloc/search_bloc.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int index;
  final Color? textColor;

  const MyTextField({
    super.key,
    required this.size,
    required this.controller,
    required this.labelText,
    this.textColor = Colors.black,
    required this.index,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6, right: 12, left: 12),
      child: SizedBox(
        width: size.width,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return TextFormField(
              onChanged: (String name) {
                if (textColor == Colors.white) {
                  context.read<SearchBloc>().add(SearchNameEvent(name));
                }
              },
              obscureText: obscureList[index],
              controller: controller,
              style: customStyle.copyWith(color: textColor),
              decoration: InputDecoration(
                  labelStyle: customStyle.copyWith(color: textColor),
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
                      : IconButton(
                          onPressed: () {
                            controller.clear();
                            context
                                .read<SearchBloc>()
                                .add(SearchInitialEvent());
                          },
                          icon: const Icon(Icons.clear, color:Colors.white)),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 10),
                      borderRadius: BorderRadius.circular(12)),
                  labelText: labelText,
                  hintText: labelText,
                  hintStyle: customStyle.copyWith(color: Colors.black),
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
      ),
    );
  }
}
