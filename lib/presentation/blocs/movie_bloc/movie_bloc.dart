import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';

import '../../../data/dara_source/movie_remote_data_source.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRemoteDataSourceImpl movieRemoteDataSourceImpl;

  MovieBloc({required this.movieRemoteDataSourceImpl}) : super(MovieInitial()) {
    on<InitialMovieEvent>(
        _takeCategory as EventHandler<InitialMovieEvent, MovieState>);
  }

 void _takeCategory(InitialMovieEvent event,Emitter<MovieState> emit ) async {
    emit(LoadingState());
    final List<MovieModel> popular =
        await movieRemoteDataSourceImpl.getPopular();
    final List<MovieModel> trending =
        await movieRemoteDataSourceImpl.getTrending();
    final List<MovieModel> playingNow =
        await movieRemoteDataSourceImpl.getPlayingNow();
    final List<MovieModel> comingSoon =
        await movieRemoteDataSourceImpl.getComingSoon();
    emit(LoadedState(
        popular: popular,
        comingSoon: comingSoon,
        playingNow: playingNow,
        trending: trending));
  }
}
