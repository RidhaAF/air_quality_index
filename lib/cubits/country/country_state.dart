part of 'country_cubit.dart';

sealed class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

final class CountryInitial extends CountryState {}

final class CountryLoading extends CountryState {}

final class CountryLoaded extends CountryState {
  final CountryModel countries;

  const CountryLoaded(this.countries);

  @override
  List<Object> get props => [countries];
}

final class CountryError extends CountryState {
  final String message;

  const CountryError(this.message);

  @override
  List<Object> get props => [message];
}
