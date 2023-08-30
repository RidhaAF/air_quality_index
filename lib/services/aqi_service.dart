import 'package:air_quality_index/helpers/default_dio.dart';
import 'package:air_quality_index/models/aqi_model.dart';
import 'package:air_quality_index/models/city_model.dart';
import 'package:air_quality_index/models/country_model.dart';
import 'package:air_quality_index/models/state_model.dart';
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

  Future<AqiModel> getSpecifiedCityAqi({
    required String country,
    required String state,
    required String city,
  }) async {
    String url = 'city?country=$country&state=$state&city=$city';

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

  Future<CountryModel> getCountries() async {
    String url = 'countries';

    try {
      Response response = await DefaultDio().option.get(url);

      final data = CountryModel.fromJson(response.data);
      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  Future<StateModel> getStates({required String country}) async {
    String url = 'states?country=$country';

    try {
      Response response = await DefaultDio().option.get(url);

      final data = StateModel.fromJson(response.data);
      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  Future<CityModel> getCities({
    required String country,
    required String state,
  }) async {
    String url = 'cities?country=$country&state=$state';

    try {
      Response response = await DefaultDio().option.get(url);

      final data = CityModel.fromJson(response.data);
      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }
}
