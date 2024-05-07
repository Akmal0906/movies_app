import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/presentation/blocs/carousel_cubit/carousel_cubit.dart';
import '../../domain/entities/movie_entity.dart';
import 'cache_network_image_widget.dart';

class CarouselWidget extends StatelessWidget {
  final List<MovieModel> pop;

  const CarouselWidget({super.key, required this.pop});

  @override
  Widget build(BuildContext context) {
    print('CarouselWidget');
    CarouselController carouselController = CarouselController();

    return Column(
      children: [
        CarouselSlider(
          disableGesture: false,
          carouselController: carouselController,
          items: List.generate(
              5,
              (index) => GestureDetector(
                onTap: (){
                  GoRouter.of(context).goNamed('movieInfoScreen',extra: pop[index]);
                },
                child: SizedBox(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CechedImageWidget(
                            posterPath: pop[index].posterPath,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Text(
                              pop[index].title ?? '',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1),
                            ),
                          )
                        ],
                      ),
                    ),
              )),
          options: CarouselOptions(
              height: 200,
              scrollDirection: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              enlargeCenterPage: true,
              reverse: false,
              onPageChanged: (index2, reason) {
                context.read<CarouselCubit>().changeIndex(index2);

                print('index $index2');
              }),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              5,
              (index1) => Row(children: [
                    GestureDetector(
                      onTap: () {
                        carouselController.animateToPage(index1,
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 500));
                      },
                      child: BlocBuilder<CarouselCubit, CarouselInitial>(
                        builder: (context, state) {
                          return CircleAvatar(
                            radius: 4,
                            backgroundColor: state.index == index1
                                ? Colors.white
                                : Colors.white54,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    )
                  ])),
        )
      ],
    );
  }
}
