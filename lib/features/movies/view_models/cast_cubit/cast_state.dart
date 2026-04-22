import '../../models/cast_model.dart';

abstract class CastState {}

class CastInitial extends CastState {}
class CastLoading extends CastState {}
class CastLoaded extends CastState {
  final List<Cast> cast;
  CastLoaded(this.cast);
}
class CastError extends CastState {
  final String message;
  CastError(this.message);
}