import 'package:flutter/material.dart';
import 'package:movies_app/utilis/all_text.dart';
class DownloadButtonWidget extends StatelessWidget {
  final String name;
  final Color backColor;
  final Function function;
  const DownloadButtonWidget({super.key,required this.name, this.backColor=Colors.pink,required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backColor.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),

            ),
            onPressed: (){function();}, child:Center(
          child: Text(name,style: customStyle,),
        )),
      ),
    );
  }
}
