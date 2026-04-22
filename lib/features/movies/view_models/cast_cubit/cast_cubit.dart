import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  final MovieRepository repository;

  CastCubit(this.repository) : super(CastInitial());

  Future<void> getCast(int movieId) async {
    emit(CastLoading());
    final result = await repository.fetchMovieCast(movieId);

    result.fold(
      (failure) => emit(CastError(failure.message)),
      (castList) {
        if (castList.isEmpty) {
          emit(CastError('لا يوجد بيانات للممثلين.'));
        } else {
          emit(CastLoaded(castList));
        }
      },
    );
  }
}