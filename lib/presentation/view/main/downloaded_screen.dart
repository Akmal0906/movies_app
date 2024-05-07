import 'package:flutter/material.dart';

import '../../../utilis/all_text.dart';
class DownloadedScreen extends StatelessWidget {
  const DownloadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('DownloadedScreen Widget');

    return SizedBox(
      child: Center(
        child: Text('Downloaded Screen',style: customStyle.copyWith(color: Colors.white,fontSize: 22),),
      ),
    );

  }

}
