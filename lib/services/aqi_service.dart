import 'package:air_quality_index/helpers/default_dio.dart';
import 'package:air_quality_index/models/aqi_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AqiService {
  Future<AqiModel> getNearestCityAqi({
    required double latitude,
    required double longitude,
  }) async {
    String url = 'nearest_city?lat=$latitude&lon=$longitude';

    try {
      Response response = await DefaultDio().option.get(url);

      final data = AqiModel.fromJson(response.data);
      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }
}
