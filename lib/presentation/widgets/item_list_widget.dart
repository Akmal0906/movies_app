import 'package:flutter/material.dart';
import 'package:movies_app/common/extension/string_extension.dart';
import 'package:movies_app/presentation/view/main/home_screen.dart';
import 'package:movies_app/utilis/all_colors.dart';
import 'package:movies_app/utilis/all_text.dart';
import '../../data/models/movie_model.dart';
import 'back_icon_button.dart';

class ItemListWidget extends StatelessWidget {
  final String count;
  final List<MovieModel> movies;

  final String categoryName;

  const ItemListWidget(
      {super.key,
      required this.count,
      required this.movies,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AllColors.primaryBackColor,
        appBar: categoryName.isNotEmpty?AppBar(
          backgroundColor: AllColors.primaryBackColor,
          centerTitle: true,
          title: Text(
            categoryName,
            style: customStyle.copyWith(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5),
          ),
          leading: buildIconButton(context),
        ):null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: buildGridView(context),
        ),
      ),
    );
  }

  GridView buildGridView(BuildContext context) {
    return GridView.custom(
          padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom + 22),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 0,
              mainAxisSpacing: 21,
              childAspectRatio: int.parse(count) == 2 ? 1 / 1.3 : 1 / 0.55,
              crossAxisCount: int.parse(count)),
          childrenDelegate: SliverChildBuilderDelegate(
              childCount: int.parse(count) == 2 ? movies.length : 7,
              (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ItemWidget(
                              width2: MediaQuery.sizeOf(context).width * 0.9,
                              movieList: movies,
                              width: 200,
                              index: index)),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 7),
                        child: Text(
                          int.parse(count) == 2
                              ? movies[index].title.toString().intelliTrim()
                              : titleList[index],
                          maxLines: 1,
                          style: customStyle.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  )),
        );
  }
}
