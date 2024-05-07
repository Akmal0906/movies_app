import '../../domain/entities/movie_entity.dart';
import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 1)
class MovieModel extends MovieEntity {
  @HiveField(0)
  final String backdropPath;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String originalTitle;
  @HiveField(4)
  final String overview;
  @HiveField(5)
  final String posterPath;
  @HiveField(6)
  final double popularity;
  @HiveField(7)
  final String releaseDate;
  @HiveField(8)
  final double voteAverage;
  @HiveField(9)
  final int voteCount;

  const MovieModel(
      {required this.backdropPath,
      required this.id,
      this.title,
      required this.originalTitle,
      required this.overview,
      required this.posterPath,
      required this.popularity,
      required this.releaseDate,
      required this.voteAverage,
      required this.voteCount})
      : super(
          id: id,
          title: title,
          posterPath: posterPath,

        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json["backdrop_path"] ?? '',
      id: json["id"],
      title: json["title"]?.toString() ?? 'null buldi',
      originalTitle: json["original_title"],
      overview: json["overview"],
      posterPath: json["poster_path"] ?? '',
      popularity: json["popularity"]?.toDouble() ?? 0.0,
      voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      voteCount: json["vote_count"],
      releaseDate: json['release_date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['title'] = title;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['popularity'] = popularity;
    data['release_date'] = releaseDate;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
