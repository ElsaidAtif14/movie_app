import '../../models/movie_model.dart';

abstract class SuggestedMoviesState {}

class SuggestedMoviesInitial extends SuggestedMoviesState {}

class SuggestedMoviesLoading extends SuggestedMoviesState {}

class SuggestedMoviesLoaded extends SuggestedMoviesState {
  final List<Movie> movies;
  final bool isFetchingMore;

  SuggestedMoviesLoaded(this.movies, {this.isFetchingMore = false});
}

class SuggestedMoviesError extends SuggestedMoviesState {
  final String message;

  SuggestedMoviesError(this.message);
}
