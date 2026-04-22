import 'movie_model.dart';

class PersonMovieCredit {
  final Movie movie;
  final String character;

  PersonMovieCredit({
    required this.movie,
    required this.character,
  });

  factory PersonMovieCredit.fromJson(Map<String, dynamic> json) {
    return PersonMovieCredit(
      movie: Movie.fromJson(json),
      character: json['character'] as String? ?? '',
    );
  }
}
