import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository repository;

  int selectedCategoryIndex = 0;
  int currentPage = 1;

  final List<Map<String, String>> categories = [
    {'title': '🔥 Trending', 'endpoint': '/movie/popular'},
    {
      'title': '🍿 Now Playing',
      'endpoint': '/movie/now_playing',
    }, // إضافة جديدة
    {'title': '⭐ Top Rated', 'endpoint': '/movie/top_rated'},
    {'title': '🎬 Upcoming', 'endpoint': '/movie/upcoming'},
    {'title': '😱 Horror', 'endpoint': '/discover/movie?with_genres=27'},
    {'title': '🤖 Sci-Fi', 'endpoint': '/discover/movie?with_genres=878'},
    {
      'title': '👊 Action',
      'endpoint': '/discover/movie?with_genres=28',
    }, // إضافة جديدة
  ];
  MoviesCubit(this.repository) : super(MoviesInitial());

  Future<void> fetchMovies([int index = 0]) async {
    selectedCategoryIndex = index;
    currentPage = 1;
    emit(MoviesLoading());

    final result = await repository.fetchMovies(
      endpoint: categories[index]['endpoint']!,
      page: currentPage,
    );

    result.fold((failure) => emit(MoviesError(failure.message)), (movies) {
      if (movies.isEmpty) {
        emit(MoviesError('No movies found.'));
      } else {
        emit(MoviesLoaded(movies));
      }
    });
  }

  Future<void> loadMoreMovies() async {
    if (state is! MoviesLoaded) return;
    final currentState = state as MoviesLoaded;
    if (currentState.isFetchingMore) return;

    emit(MoviesLoaded(currentState.movies, isFetchingMore: true));

    currentPage++;
    final result = await repository.fetchMovies(
      endpoint: categories[selectedCategoryIndex]['endpoint']!,
      page: currentPage,
    );

    result.fold(
      (failure) =>
          emit(MoviesLoaded(currentState.movies, isFetchingMore: false)),
      (newMovies) {
        final allMovies = List<Movie>.from(currentState.movies)
          ..addAll(newMovies);
        emit(MoviesLoaded(allMovies, isFetchingMore: false));
      },
    );
  }

  Future<void> refreshMovies() async {
    currentPage = 1;

    final result = await repository.fetchMovies(
      endpoint: categories[selectedCategoryIndex]['endpoint']!,
      page: currentPage,
    );

    result.fold((failure) => emit(MoviesError(failure.message)), (movies) {
      if (movies.isNotEmpty) {
        emit(MoviesLoaded(movies));
      } else {
        emit(MoviesError('No movies found on refresh.'));
      }
    });
  }

  Future<void> fetchSuggestedCountryMovies(String countryCode) async {
    emit(MoviesLoading());

    final result = await repository.fetchSuggestedCountryMovies(countryCode);

    result.fold((failure) => emit(MoviesError(failure.message)), (movies) {
      if (movies.isEmpty) {
        emit(MoviesError('No movies found for the selected country.'));
      } else {
        emit(MoviesLoaded(movies));
      }
    });
  }
}
