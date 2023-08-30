part of 'aqi_cubit.dart';

sealed class AqiState extends Equatable {
  const AqiState();

  @override
  List<Object> get props => [];
}

final class AqiInitial extends AqiState {}

final class AqiLoading extends AqiState {}

final class AqiLoaded extends AqiState {
  final AqiModel aqiModel;

  const AqiLoaded(this.aqiModel);

  @override
  List<Object> get props => [aqiModel];
}

final class AqiError extends AqiState {
  final String message;

  const AqiError(this.message);

  @override
  List<Object> get props => [message];
}
