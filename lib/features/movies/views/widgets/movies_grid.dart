import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movies/features/movies/views/widgets/movie_card.dart';
import '../../models/movie_model.dart';

/// Provides grid delegate and item builder for use with SliverGrid
/// This widget is kept for backward compatibility and can wrap SliverGrid
class MoviesGrid extends StatelessWidget {
  final List<Movie> movies;
  final bool useSliverGrid;

  const MoviesGrid({
    super.key,
    required this.movies,
    this.useSliverGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useSliverGrid) {
      // Return just the grid content for use in CustomScrollView
      return _buildSliverGridContent();
    }

    // Fallback for non-sliver usage (deprecated approach)
    return 
    
    GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .90,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 600),
          columnCount: 2,
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: MovieCard(movie: movies[index])),
          ),
        );
      },
    );
  }

  Widget _buildSliverGridContent() {
    return AnimationLimiter(
      child: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .90,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 600),
              columnCount: 2,
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: MovieCard(movie: movies[index]),
                ),
              ),
            );
          },
          childCount: movies.length,
        ),
      ),
    );
  }
}
