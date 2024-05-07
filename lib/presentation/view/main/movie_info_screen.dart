import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/data/hive_box/local_storage.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/presentation/widgets/cache_network_image_widget.dart';
import 'package:movies_app/utilis/all_colors.dart';
import 'package:movies_app/utilis/all_text.dart';
import '../../widgets/back_icon_button.dart';
import '../../widgets/download_button_widget.dart';

class MovieInfoScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieInfoScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isTrue=moviesList.containsKey(movie.id);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AllColors.primaryBackColor,
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.43,
              width: size.width,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.bottomCenter,
                children: [
                  CechedImageWidget(posterPath: movie.posterPath),
                  Positioned(
                      top: 9, left: 7, child: buildIconButton(context)),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed('videoPlayerScreen', pathParameters: {
                            'videoUrl':
                                'https://www.youtube.com/watch?v=XEjLoHdbVeE&list=RDXEjLoHdbVeE&start_radio=1'
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AllColors.primaryBackColor.withOpacity(0.1),
                              AllColors.primaryBackColor.withOpacity(0.3),
                              AllColors.primaryBackColor,
                            ]),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, -6),
                            spreadRadius: 15,
                            blurRadius: 12,
                            color: AllColors.primaryBackColor,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 54,
                              padding:
                                  const EdgeInsets.only(top: 13, bottom: 13),
                              margin: const EdgeInsets.only(
                                right: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.pink.shade400,
                                      Colors.black87
                                    ]),
                              ),
                              child: Text(
                                'Watch online',
                                style:
                                    customStyle.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                  height: 52,
                                  width: 52,
                                  child: ColoredBox(
                                      color: AllColors.saveButtonBackColor,
                                      child: StatefulBuilder(
                                        builder: (context,setState) {
                                          return IconButton(
                                              onPressed: () {
                                                setState(()=>isTrue=!isTrue);
                                              isTrue?moviesList.put(movie.id, movie):moviesList.delete(movie.id);
                                                print(moviesList.values.toString());
                                              },
                                              icon: Icon(
                                                isTrue?Icons.bookmark:Icons.bookmark_border_sharp,
                                                color: Colors.white,
                                                size: 26,
                                              ));
                                        }
                                      )))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 7, right: 7, top: 19, bottom: 11),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ColoredBox(
                  color: AllColors.saveButtonBackColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5, top: 8, bottom: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title.toString(),
                          style: customStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              fontSize: 16),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5.0, bottom: 17),
                          child: Text(
                            movie.releaseDate,
                            style: customStyle.copyWith(
                                color: Colors.white70,
                                fontSize: 14,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          ' ${movie.overview}',
                          style: customStyle.copyWith(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              BoxTextWidget(
                  title: movie.voteAverage.toString(),
                  subtitle: 'Vote average'),
              BoxTextWidget(
                  title: movie.popularity.toString(), subtitle: 'Popular'),
              BoxTextWidget(
                  title: movie.voteCount.toString(), subtitle: 'Vote count'),
            ]),
            Expanded(child: Align(
              alignment: Alignment.bottomCenter,
              child: DownloadButtonWidget(name: 'Download',backColor: Colors.pink.shade400, function: (){
                GoRouter.of(context).pushNamed('chooseDownloadScreen',pathParameters: {'videoUrl':'https://www.youtube.com/watch?v=XEjLoHdbVeE&list=RDXEjLoHdbVeE&start_radio=1'});

              },),
            ))


          ],
        ),
      ),
    );
  }
}

class BoxTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const BoxTextWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 56,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AllColors.saveButtonBackColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: customStyle.copyWith(
                  fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
            Text(
              subtitle,
              style: customStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
