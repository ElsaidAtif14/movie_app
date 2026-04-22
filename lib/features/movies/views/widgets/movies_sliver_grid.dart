import 'package:flutter/material.dart';
import 'package:movies/core/constants/ui_constants.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/views/widgets/movie_grid_item.dart';

/// A reusable SliverGrid component that displays movies
/// Handles both loading and loaded states with a unified interface
class MoviesSliverGrid extends StatelessWidget {
  final List<Movie> movies;
  final bool isLoading;

  const MoviesSliverGrid({
    super.key,
    required this.movies,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading
        ? MoviesUIConstants.gridSkeletonItemCount
        : movies.length;

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MoviesUIConstants.gridCrossAxisCount,
        childAspectRatio: MoviesUIConstants.gridChildAspectRatio,
        crossAxisSpacing: MoviesUIConstants.gridCrossAxisSpacing,
        mainAxisSpacing: MoviesUIConstants.gridMainAxisSpacing,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => MovieGridItem(
          movie: isLoading ? null : movies[index],
          index: index,
          isLoading: isLoading,
        ),
        childCount: itemCount,
      ),
    );
  }
}
