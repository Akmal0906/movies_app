import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/flower.svg',
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.white70,
                  Colors.white,
                  Colors.white60,
                  Colors.white
                ])),
          ),
        ],
      ),
    );
  }
}
