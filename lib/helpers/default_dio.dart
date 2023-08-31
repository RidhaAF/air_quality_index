import 'package:air_quality_index/utilities/env.dart';
import 'package:dio/dio.dart';

class DefaultDio {
  Dio option = Dio(
    BaseOptions(
      baseUrl: Env.baseURL,
      queryParameters: {
        'key': Env.apiKey,
      },
    ),
  );
}
