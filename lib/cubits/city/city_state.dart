part of 'city_cubit.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityLoaded extends CityState {
  final CityModel cities;

  const CityLoaded(this.cities);

  @override
  List<Object> get props => [cities];
}

final class CityError extends CityState {
  final String message;

  const CityError(this.message);

  @override
  List<Object> get props => [message];
}
