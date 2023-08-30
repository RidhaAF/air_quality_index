import 'package:air_quality_index/models/state_model.dart';
import 'package:air_quality_index/services/aqi_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'state_province_state.dart';

class StateProvinceCubit extends Cubit<StateProvinceState> {
  late StateModel states;
  StateProvinceCubit() : super(StateProvinceInitial());

  Future<void> getStates({required String country}) async {
    emit(StateProvinceLoading());
    try {
      states = await AqiService().getStates(country: country);
      emit(StateProvinceLoaded(states));
    } catch (e) {
      emit(StateProvinceError(e.toString()));
    }
  }

  List<StateData>? getStatesData() {
    return states.data;
  }
}
