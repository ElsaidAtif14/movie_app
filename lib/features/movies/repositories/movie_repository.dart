import 'package:dartz/dartz.dart';
import 'package:movies/core/failures/failure.dart';
import 'package:movies/features/movies/models/cast_model.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/models/person_model.dart';
import 'package:movies/features/movies/models/person_movie_credit_model.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> fetchMovies({required String endpoint, required int page});
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, List<Cast>>> fetchMovieCast(int movieId);
  Future<Either<Failure, String>> fetchMovieTrailer(int movieId);
  Future<Either<Failure, Person>> fetchPersonDetails(int personId);
  Future<Either<Failure, List<PersonMovieCredit>>> fetchPersonMovieCredits(int personId);
  Future<Either<Failure, List<Movie>>> fetchSuggestedCountryMovies(String countryCode);
}

