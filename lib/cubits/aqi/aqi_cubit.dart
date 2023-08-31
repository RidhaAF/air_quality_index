import 'package:air_quality_index/models/aqi_model.dart';
import 'package:air_quality_index/services/aqi_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aqi_state.dart';

class AqiCubit extends Cubit<AqiState> {
  late AqiModel aqiModel;
  AqiCubit() : super(AqiInitial());

  Future<void> getNearestCityAqi({
    required double latitude,
    required double longitude,
  }) async {
    emit(AqiLoading());

    try {
      aqiModel = await AqiService().getNearestCityAqi(
        latitude: latitude,
        longitude: longitude,
      );
      emit(AqiLoaded(aqiModel));
    } catch (e) {
      emit(AqiError(e.toString()));
    }
  }

  Future<void> getSpecifiedCityAqi({
    required String country,
    required String state,
    required String city,
  }) async {
    emit(AqiLoading());

    try {
      aqiModel = await AqiService().getSpecifiedCityAqi(
        country: country,
        state: state,
        city: city,
      );
      emit(AqiLoaded(aqiModel));
    } catch (e) {
      emit(AqiError(e.toString()));
    }
  }
}
