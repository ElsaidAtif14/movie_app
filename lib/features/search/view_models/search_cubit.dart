import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MovieRepository repository;

  SearchCubit(this.repository) : super(SearchInitial());

  Future<void> search(String query) async {
    // التحقق من أن النص ليس فارغاً أو مجرد مسافات
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    final result = await repository.searchMovies(query);

    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (movies) {
        if (movies.isEmpty) {
          emit(SearchError('No movies found with this name 😕'));
        } else {
          emit(SearchLoaded(movies));
        }
      },
    );
  }

  // ميثود لمسح نتائج البحث والعودة للحالة الابتدائية
  void clearSearch() {
    emit(SearchInitial());
  }
}