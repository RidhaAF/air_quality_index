import 'package:air_quality_index/models/country_model.dart';
import 'package:air_quality_index/services/aqi_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  late CountryModel countries;
  CountryCubit() : super(CountryInitial());

  Future<void> getCountries() async {
    emit(CountryLoading());

    try {
      countries = await AqiService().getCountries();
      emit(CountryLoaded(countries));
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }

  List<Country>? getCountriesData() {
    return countries.data;
  }
}
