import 'package:air_quality_index/models/city_model.dart';
import 'package:air_quality_index/services/aqi_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  late CityModel cities;
  CityCubit() : super(CityInitial());

  Future<void> getCities(
      {required String country, required String state}) async {
    emit(CityLoading());
    try {
      cities = await AqiService().getCities(country: country, state: state);
      emit(CityLoaded(cities));
    } catch (e) {
      emit(CityError(e.toString()));
    }
  }

  List<City>? getCitiesData() {
    return cities.data;
  }
}
