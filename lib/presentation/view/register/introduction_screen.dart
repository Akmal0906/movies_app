import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/utilis/all_text.dart';

import '../../widgets/elevated_button_widget.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage(
              'assets/images/introduce.jpg',
            ),
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
          Positioned(
              bottom: 5,
              height: size.height/3,
              width: size.width,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding:const EdgeInsets.only(left: 12,right: 4,bottom: 12,top: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 4,
                          offset: Offset(7, 0),
                          color: Colors.white30),
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.white60,
                          Colors.white54
                        ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: size.width,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Text(
                                AllText.welcome,
                                style: customStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 13,),
                              Text(
                                AllText.introduce,
                                style: customStyle.copyWith(
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          4,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.animateToPage(index,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: currentIndex == index ? 24 : 12,
                                    height: currentIndex == index ? 12 : 12,
                                    decoration: BoxDecoration(
                                      color: currentIndex == index
                                          ? Colors.black
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                    const SizedBox(height: 17,),
                    elevatedButtonWidget(context,(){GoRouter.of(context).pushReplacementNamed('signup');},Size(size.width*0.4, 46),AllText.started,Colors.grey.shade500),
                  ],
                ),
              )),
        ],
      ),
    );
  }


}
