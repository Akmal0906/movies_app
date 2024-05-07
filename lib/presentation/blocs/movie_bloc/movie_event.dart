part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();
}
final class InitialMovieEvent extends MovieEvent{
  @override
  List<Object?> get props => [];
}


