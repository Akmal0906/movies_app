import 'package:flutter/material.dart';
import 'package:movies_app/common/extension/string_extension.dart';
import 'package:movies_app/data/hive_box/local_storage.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/presentation/widgets/download_button_widget.dart';
import 'package:movies_app/utilis/all_colors.dart';
import '../../../utilis/all_text.dart';
import '../../widgets/cache_network_image_widget.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isVisible=false;
    return StatefulBuilder(
      builder: (context,setState) {
        return moviesList.isEmpty
            ? Center(
                child: Text(
                  AllText.didnotAdd,
                  style: customStyle.copyWith(color: Colors.white, fontSize: 22),
                ),
              )
            : Column(children: [
                SizedBox(
                  height: 52,
                  width: size.width,
                  child:isVisible?GestureDetector(
                      onTap: (){
                        setState(()=>isVisible=!isVisible);
                      },
                      child: const SaveScreenTopButton(name: AllText.cancel)): Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    useSafeArea: true,
                                    barrierColor: Colors.black38,
                                    constraints: const BoxConstraints(
                                      maxHeight: 200,
                                      minHeight: 156
                                    ),

                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    builder: (BuildContext context) {
                                      return ColoredBox(
                                        color: AllColors.primaryBackColor
                                            .withOpacity(0.9),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 16.0,bottom: 8),
                                              child: Text(
                                                AllText.notifTextBottomSheet,
                                                style: customStyle.copyWith(fontSize: 16,letterSpacing: 1,fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                            DownloadButtonWidget(
                                                name: AllText.confirm,
                                                function: () {
                                                  moviesList.clear().whenComplete((){
                                                    setState((){} );
                                                    Navigator.of(context).pop();
                                                  });





                                                }),
                                            DownloadButtonWidget(
                                                name: AllText.cancel,backColor: Colors.white54,
                                                function: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: const SaveScreenTopButton(
                                name: AllText.clearAll,
                              ))),
                      const SizedBox(
                        width: 12,
                      ),
                       Expanded(child: GestureDetector(
                          onTap: (){setState(()=>isVisible=!isVisible);},
                          child:const SaveScreenTopButton(name: AllText.clearSelect))),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.custom(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom + 22, top: 12),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 21,
                      childAspectRatio: 1 / 1.3,
                      crossAxisCount: 2,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                        childCount: moviesList.length, (context, index) {
                      MovieModel movieModel = moviesList.getAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  CechedImageWidget(
                                      posterPath: movieModel.posterPath),
                                  Positioned(
                                    right: -10,
                                    top: -10,
                                    child: Visibility(
                                        visible: isVisible,
                                        child: IconButton(
                                          icon:const Icon(Icons.clear,color: Colors.white54,size: 21,),
                                          onPressed: (){
                                            moviesList.delete(movieModel.id).whenComplete(() => setState(()=>{}));
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              movieModel.title.toString().intelliTrim(),
                              style: customStyle.copyWith(
                                overflow: TextOverflow.ellipsis,
                                letterSpacing: 0.5,
                              ),
                              maxLines: 2,
                            ),
                            Text(
                              movieModel.releaseDate,
                              style: customStyle.copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ]);
      }
    );
  }
}

class SaveScreenTopButton extends StatelessWidget {
  final String name;

  const SaveScreenTopButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ColoredBox(
        color: AllColors.saveButtonBackColor.withOpacity(0.25),
        child: Center(
          child: Text(
            name,
            style: customStyle,
          ),
        ),
      ),
    );
  }
}
