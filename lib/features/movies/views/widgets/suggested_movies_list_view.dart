import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helpers/movie_dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:movies/features/movies/view_models/suggested_movies_cubit/suggested_movies_cubit.dart';
import 'package:movies/features/movies/view_models/suggested_movies_cubit/suggested_movies_state.dart';
import 'package:movies/features/movies/views/widgets/movie_card.dart';

class SuggestedMoviesListView extends StatefulWidget {
  const SuggestedMoviesListView({super.key});

  @override
  State<SuggestedMoviesListView> createState() => _SuggestedMoviesListViewState();
}

class _SuggestedMoviesListViewState extends State<SuggestedMoviesListView> {
  @override
  void initState() {
    super.initState();
    // لا تستدعي الـ API هنا، ستُستدعى من home_view_body عند الحاجة
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestedMoviesCubit, SuggestedMoviesState>(
      builder: (context, state) {
        if (state is SuggestedMoviesError) {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }

        final bool isLoading = state is SuggestedMoviesLoading || state is SuggestedMoviesInitial;
        final movies = (state is SuggestedMoviesLoaded) 
            ? state.movies 
            : MovieDummyData.movieList;

        return SliverToBoxAdapter(
          child: Skeletonizer(
            enabled: isLoading,
            child: SizedBox(
              height: 200, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.take(5).length, // عرض 5 أفلام فقط
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 150,
                      child: MovieCard(movie: movies[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}