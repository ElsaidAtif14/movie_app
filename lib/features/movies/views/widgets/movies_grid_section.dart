import 'package:flutter/material.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/views/widgets/movies_sliver_grid.dart';

class MoviesGridSection extends StatelessWidget {
  final bool isLoading;
  final List<Movie> movies;

  const MoviesGridSection({super.key, required this.isLoading, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: MoviesSliverGrid(
        isLoading: isLoading,
        movies: movies.skip(isLoading ? 0 : 5).toList(),
      ),
    );
  }
}