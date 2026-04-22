import '../../models/movie_model.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;
  final bool isFetchingMore; 

  MoviesLoaded(this.movies, {this.isFetchingMore = false}); 
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);
}