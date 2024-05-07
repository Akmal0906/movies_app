import 'movie_model.dart';

class MoviesResultModel {
  final List<MovieModel> movies;

  MoviesResultModel(this.movies);

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) {
    return MoviesResultModel(
        List<MovieModel>.from(json["results"].map((x) => MovieModel.fromJson(x)))
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = movies.map((v) => v.toJson()).toList();

    return data;
  }
}
