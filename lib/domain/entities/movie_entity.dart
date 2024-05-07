import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final int id;

  final String? title;



  const MovieEntity({
    required this.posterPath,
    required this.id,
      this.title,

  });

  MovieEntity copyWith(String? title, int id, String posterPath) =>
      MovieEntity(posterPath: posterPath, id: id, title: title ?? this.title);

  @override
  List<Object?> get props => [id, title];

  @override
  bool get stringify => true;
}
