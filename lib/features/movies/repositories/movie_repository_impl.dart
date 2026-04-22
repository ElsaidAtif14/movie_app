import 'package:dartz/dartz.dart';
import 'package:movies/core/failures/failure.dart';
import 'package:movies/core/services/database_service.dart';
import 'package:movies/features/movies/models/cast_model.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/models/person_model.dart';
import 'package:movies/features/movies/models/person_movie_credit_model.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DatabaseService databaseService;

  MovieRepositoryImpl(this.databaseService);

  @override
  Future<Either<Failure, List<Movie>>> fetchMovies({
    required String endpoint,
    required int page,
  }) async {
    try {
      final response = await databaseService.get(
        endpoint,
        queryParameters: {'page': page},
      );

      final rawMovies = _parseResults(response);
      final movies = rawMovies
          .map((json) => Movie.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Cast>>> fetchMovieCast(int movieId) async {
    try {
      final response = await databaseService.get('/movie/$movieId/credits');
      final castJson = response is Map<String, dynamic>
          ? response['cast']
          : null;

      if (castJson is List) {
        return Right(
          castJson.cast<Map<String, dynamic>>().map(Cast.fromJson).toList(),
        );
      }

      return const Left(UnexpectedFailure('Failed to parse movie cast.'));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> fetchMovieTrailer(int movieId) async {
    try {
      final response = await databaseService.get('/movie/$movieId/videos');
      final results = response is Map<String, dynamic>
          ? response['results']
          : null;

      if (results is List) {
        final trailer = results.cast<Map<String, dynamic>>().firstWhere(
          (item) =>
              item['site']?.toString().toLowerCase() == 'youtube' &&
              item['key'] != null &&
              item['key'].toString().isNotEmpty,
          orElse: () => <String, dynamic>{},
        );

        final key = trailer['key']?.toString();
        if (key != null && key.isNotEmpty) {
          return Right(key);
        }
      }

      return const Left(ServerFailure('No trailer available for this movie.'));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Person>> fetchPersonDetails(int personId) async {
    try {
      final response = await databaseService.get('/person/$personId');
      if (response is Map<String, dynamic>) {
        return Right(Person.fromJson(response));
      }
      return const Left(UnexpectedFailure('Failed to parse person details.'));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PersonMovieCredit>>> fetchPersonMovieCredits(
    int personId,
  ) async {
    try {
      final response = await databaseService.get(
        '/person/$personId/movie_credits',
      );
      final castJson = response is Map<String, dynamic>
          ? response['cast']
          : null;

      if (castJson is List) {
        return Right(
          castJson
              .cast<Map<String, dynamic>>()
              .map(PersonMovieCredit.fromJson)
              .toList(),
        );
      }
      return const Left(UnexpectedFailure('Failed to parse person credits.'));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final response = await databaseService.get(
        '/search/movie',
        queryParameters: {'query': query, 'page': 1},
      );

      final rawMovies = _parseResults(response);
      final movies = rawMovies
          .map((json) => Movie.fromJson(json as Map<String, dynamic>))
          .toList();
      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  List<dynamic> _parseResults(dynamic response) {
    if (response is Map<String, dynamic> && response['results'] is List) {
      return response['results'] as List<dynamic>;
    }
    throw const UnexpectedFailure('Invalid response format.');
  }

  @override
  Future<Either<Failure, List<Movie>>> fetchSuggestedCountryMovies(
    String countryCode,
  ) async {
    try {
      final response = await databaseService.get(
        '/discover/movie',
        queryParameters: {
          'with_origin_country': countryCode
        },
      );

      final rawMovies = _parseResults(response);
      final movies = rawMovies
          .map((json) => Movie.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(movies);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
