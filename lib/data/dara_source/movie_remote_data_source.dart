import '../api_config/api_client.dart';
import '../models/movie_model.dart';
import '../models/movie_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();

  Future<List<MovieModel>> getPopular();

  Future<List<MovieModel>> getPlayingNow();

  Future<List<MovieModel>> getComingSoon();
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _apiClient;

  MovieRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _apiClient.get('trending/movie/day');
    final List<MovieModel> movies = MoviesResultModel.fromJson(response).movies;
    //print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final  response = await _apiClient.get('movie/popular');
    final List<MovieModel> movies = MoviesResultModel.fromJson(response).movies;
   // print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
    final response = await _apiClient.get('movie/upcoming');
    final List<MovieModel> movies = MoviesResultModel.fromJson(response).movies;
   // print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final response = await _apiClient.get('movie/now_playing');
    final List<MovieModel> movies = MoviesResultModel.fromJson(response).movies;
   // print(movies);
    return movies;
  }
}
