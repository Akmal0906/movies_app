import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/api_config/api.dart';
class CechedImageWidget extends StatelessWidget {
  final String posterPath;
  const CechedImageWidget({
    super.key,
    required this.posterPath,
  });


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ApiConfig.imageBaseUrl +
          posterPath,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                  Colors.black12, BlendMode.difference)),
        ),
      ),
      placeholder: (context, url) =>
       Center(
         child: CircularProgressIndicator(
          color: Colors.white54,
          value: 4,
          backgroundColor: Colors.indigo.shade900,
               ),
       ),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),
    );
  }
}
