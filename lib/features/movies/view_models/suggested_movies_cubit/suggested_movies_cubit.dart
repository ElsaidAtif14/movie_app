import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/shared_preferences_singleton.dart';
import '../../../../core/utils/app_key.dart';
import '../../models/movie_model.dart';
import '../../repositories/movie_repository.dart';
import 'suggested_movies_state.dart';

class SuggestedMoviesCubit extends Cubit<SuggestedMoviesState> {
  final MovieRepository repository;
  int currentPage = 1;
  String currentCountry = '';

  SuggestedMoviesCubit(this.repository) : super(SuggestedMoviesInitial());

  Future<void> fetchSuggestedMovies(String countryCode) async {
    currentCountry = countryCode;
    currentPage = 1;
    emit(SuggestedMoviesLoading());

    final result = await repository.fetchSuggestedCountryMovies(countryCode);

    result.fold(
      (failure) => emit(SuggestedMoviesError(failure.message)),
      (movies) {
        if (movies.isEmpty) {
          emit(SuggestedMoviesError('No suggested movies found.'));
        } else {
          emit(SuggestedMoviesLoaded(movies));
        }
      },
    );
  }

  Future<void> loadMoreSuggestedMovies() async {
    if (state is! SuggestedMoviesLoaded) return;
    final currentState = state as SuggestedMoviesLoaded;
    if (currentState.isFetchingMore) return;

    emit(SuggestedMoviesLoaded(currentState.movies, isFetchingMore: true));

    currentPage++;
    final result =
        await repository.fetchSuggestedCountryMovies(currentCountry);

    result.fold(
      (failure) =>
          emit(SuggestedMoviesLoaded(currentState.movies, isFetchingMore: false)),
      (newMovies) {
        final allMovies = List<Movie>.from(currentState.movies)
          ..addAll(newMovies);
        emit(SuggestedMoviesLoaded(allMovies, isFetchingMore: false));
      },
    );
  }

  Future<void> refreshSuggestedMovies() async {
    currentPage = 1;
    
    // Ensure we have a country code
    if (currentCountry.isEmpty) {
      currentCountry = Prefs.getString(AppKey.countryKey);
    }

    final result =
        await repository.fetchSuggestedCountryMovies(currentCountry);

    result.fold(
      (failure) => emit(SuggestedMoviesError(failure.message)),
      (movies) {
        if (movies.isNotEmpty) {
          emit(SuggestedMoviesLoaded(movies));
        } else {
          emit(SuggestedMoviesError('No movies found on refresh.'));
        }
      },
    );
  }
}
