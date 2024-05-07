part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();
}

final class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

final class LoadedState extends MovieState {
  final List<MovieModel> trending;
  final List<MovieModel> popular;
  final List<MovieModel> comingSoon;
  final List<MovieModel> playingNow;

  const LoadedState(
      {required this.popular,
      required this.comingSoon,
      required this.playingNow,
      required this.trending});

  @override
  List<Object> get props => [trending, popular, comingSoon, playingNow];
}

final class LoadingErrorState extends MovieState {
  final String error;

  const LoadingErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
