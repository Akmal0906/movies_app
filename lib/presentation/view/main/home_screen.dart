import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/blocs/carousel_cubit/carousel_cubit.dart';
import 'package:movies_app/presentation/widgets/cache_network_image_widget.dart';
import 'package:movies_app/utilis/all_text.dart';
import '../../../data/models/movie_model.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../blocs/movie_bloc/movie_bloc.dart';
import '../../widgets/carousel_widget.dart';
import '../../widgets/circle_progress_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Home Widget');
    final Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircleProgressWidget();
          } else if (state is LoadedState) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery
                      .paddingOf(context)
                      .bottom + 19),
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 24, right: 12, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AllText.kinoPlay,
                          style: customStyle.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_active,
                              color: Colors.white70,
                              size: 22,
                            ))
                      ],
                    ),
                  ),
                  BlocProvider(
                    create: (context) => CarouselCubit(),
                    child: CarouselWidget(
                      pop: state.popular,
                    ),
                  ),
                  ItemListBuilderWidget(
                    height: size.height * 0.3,
                    width: size.width,
                    movieList: state.popular,
                    categoryName: AllText.popular,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9, top: 12),
                    child: Column(
                      children: [
                        CategoryWidget(
                          name: AllText.category,
                          movies: state.comingSoon,
                          count: '1',
                        ),
                        SizedBox(
                          height: size.height * 0.27,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  ItemWidget(
                                      width2: size.width * 0.87,
                                      width: size.width,
                                      movieList: state.comingSoon,
                                      index: index),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 15.0),
                                    child: Text(
                                      titleList[index],
                                      style: customStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.5),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ItemListBuilderWidget(
                    height: size.height * 0.3,
                    width: size.width,
                    movieList: state.trending,
                    categoryName: AllText.trending,
                  ),
                  ItemListBuilderWidget(
                    height: size.height * 0.3,
                    width: size.width,
                    movieList: state.playingNow,
                    categoryName: AllText.ongiong,
                  ),
                  ItemListBuilderWidget(
                    height: size.height * 0.3,
                    width: size.width,
                    movieList: state.comingSoon,
                    categoryName: AllText.coomingSoon,
                  ),
                ],
              ),
            );
          } else if (state is LoadingErrorState) {}
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


class ItemListBuilderWidget extends StatelessWidget {
  final double height;
  final double width;
  final double? width2;
  final String categoryName;
  final List<MovieModel> movieList;

  const ItemListBuilderWidget({super.key,
    required this.movieList,
    required this.height,
    required this.width,
    required this.categoryName,
    this.width2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryWidget(
          name: categoryName,
          movies: movieList,
        ),
        SizedBox(
          height: height,
          width: width,
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: ItemWidget(
                  width2: width2,
                  width: width,
                  movieList: movieList,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key,
    this.width2,
    required this.width,
    required this.movieList,
    required this.index});

  final double? width2;
  final double width;
  final List<MovieModel> movieList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width2 ?? width * 0.43,
        margin: const EdgeInsets.only(left: 13),
        child: GestureDetector(
            onTap: () {
              GoRouter.of(context)
                  .pushNamed('movieInfoScreen', extra: movieList[index]);
            },
            child: CechedImageWidget(posterPath: movieList[index].posterPath)));
  }
}

class CategoryWidget extends StatelessWidget {
  final String name;
  final List<MovieEntity> movies;
  final String? count;

  const CategoryWidget(
      {super.key, required this.name, required this.movies, this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21, left: 12, right: 12, bottom: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: customStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
                fontSize: 16),
          ),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed('itemListWidget',
                  extra: movies,
                  pathParameters: {
                    'categoryName': name,
                    'count': count ?? '2'
                  });
            },
            child: Text(
              AllText.seeAll,
              style: customStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
