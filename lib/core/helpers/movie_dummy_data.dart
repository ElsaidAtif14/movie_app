import 'package:movies/features/movies/models/movie_model.dart';

class MovieDummyData {
  // دالة لإنشاء قائمة من 10 أفلام مثلاً بناءً على بيانات نموذجية
  static List<Movie> generateDummyMovies() {
    return List.generate(10, (index) {
      return Movie(
        id: index, 
        title: "Movie Title $index",
        overview: "This is a dummy description for movie number $index. It provides helpful context for testing the UI.",
        posterPath: "/8IB2B7OqzD42nFeBYfk4CdZ2dyk.jpg",
        releaseDate: "2024-01-01",
        voteAverage: 7.5 + (index % 3) * 0.5,
      );
    });
  }

  static final List<Movie> movieList = generateDummyMovies();
}