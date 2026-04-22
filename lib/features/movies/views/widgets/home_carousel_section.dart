import 'package:flutter/material.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/views/widgets/home_carousel.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCarouselSection extends StatelessWidget {
  final bool isLoading;
  final List<Movie> movies;

  const HomeCarouselSection({super.key, required this.isLoading, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Skeletonizer(
          enabled: isLoading,
          child: HomeCarousel(movies: movies.take(5).toList()),
        ),
      ),
    );
  }
}