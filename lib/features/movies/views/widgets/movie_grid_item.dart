import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movies/core/constants/ui_constants.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/views/widgets/movie_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Reusable widget for a single grid item with animation
/// Handles both normal and skeleton states
class MovieGridItem extends StatelessWidget {
  final Movie? movie;
  final int index;
  final bool isLoading;

  const MovieGridItem({
    super.key,
    required this.movie,
    required this.index,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Skeletonizer(
        enabled: true,
        effect: ShimmerEffect(
          baseColor: Colors.grey[900]!, // لون الهيكل الثابت
          highlightColor: Colors.grey[600]!, // لون اللمعة المتحركة
          duration: const Duration(seconds: 1),
        ),
        child: MovieCard(movie: movie ?? _buildDummyMovie()),
      );
    }

    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: const Duration(
        milliseconds: MoviesUIConstants.animationDurationMs,
      ),
      columnCount: MoviesUIConstants.gridCrossAxisCount,
      child: SlideAnimation(
        verticalOffset: MoviesUIConstants.animationVerticalOffset,
        child: FadeInAnimation(child: MovieCard(movie: movie!)),
      ),
    );
  }

  /// Creates a dummy movie for skeleton loading
  Movie _buildDummyMovie() {
    return Movie(
      id: index,
      title: '',
      overview: '',
      posterPath: '',
      voteAverage: 0,
      releaseDate: '',
    );
  }
}
