import 'package:movies_app/data/api_config/api_client.dart';
import 'package:movies_app/data/models/movie_model.dart';

import '../models/movie_result_model.dart';

class MovieSearchRemote {
  final ApiClient apiClient;

  const MovieSearchRemote(this.apiClient);

  Future<List<MovieModel>?> searchWithCollection(String movieName) async {
    final response = await apiClient.get('/search/movie', movieName);
    if (response['results'].isEmpty) {
      return null;
    } else {
      final List<MovieModel> movies =
          MoviesResultModel.fromJson(response).movies;
      return movies;
    }
  }
}
