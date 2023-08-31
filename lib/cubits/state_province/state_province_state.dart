part of 'state_province_cubit.dart';

sealed class StateProvinceState extends Equatable {
  const StateProvinceState();

  @override
  List<Object> get props => [];
}

final class StateProvinceInitial extends StateProvinceState {}

final class StateProvinceLoading extends StateProvinceState {}

final class StateProvinceLoaded extends StateProvinceState {
  final StateModel states;

  const StateProvinceLoaded(this.states);

  @override
  List<Object> get props => [states];
}

final class StateProvinceError extends StateProvinceState {
  final String message;

  const StateProvinceError(this.message);

  @override
  List<Object> get props => [message];
}
