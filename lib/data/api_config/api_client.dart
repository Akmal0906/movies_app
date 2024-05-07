import 'package:dio/dio.dart';
import 'package:movies_app/data/api_config/api.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  dynamic get(String path, [String? movieName='']) async {
    try {
      // print('working');
      final response = await _dio.get(
        '${ApiConfig.baseUrl}$path',
        queryParameters: {'query': movieName},
        options: Options(
          sendTimeout: const Duration(seconds: 1),
          receiveTimeout: const Duration(seconds: 1),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${ApiConfig.accessToken}'
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String,dynamic>;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException {}
  }
}
