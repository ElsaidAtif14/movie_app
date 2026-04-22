import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import '../../../../core/constants/app_colors.dart';
import '../models/movie_model.dart';
import '../view_models/cast_cubit/cast_cubit.dart';
import 'widgets/movie_details_app_bar.dart';
import 'widgets/movie_info_chips.dart';
import 'widgets/movie_storyline_section.dart';
import 'widgets/movie_cast_section.dart';
import 'widgets/trailer_button.dart';

class MovieDetailsView extends StatelessWidget {
  final Movie movie;
  final String heroTag; 

  const MovieDetailsView({
    super.key, 
    required this.movie, 
    required this.heroTag, 
  });

  @override
  Widget build(BuildContext context) {
    final year = movie.releaseDate.isNotEmpty
        ? movie.releaseDate.split('-')[0]
        : 'N/A';

    return BlocProvider(
      create: (context) => CastCubit(getIt<MovieRepository>())..getCast(movie.id),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            MovieDetailsAppBar(movie: movie, heroTag: heroTag),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MovieInfoSection(movie: movie),
                    const SizedBox(height: 8),
                    MovieInfoChips(year: year),
                    const SizedBox(height: 8),
                    const Divider(
                      color: AppColors.secondaryBackground,
                      thickness: 2,
                    ),
                    const SizedBox(height: 8),
                    const MovieCastSection(),
                     const Divider(
                      color: AppColors.secondaryBackground,
                      thickness: 2,
                    ),
                    const SizedBox(height: 12),
                    MovieStorylineSection(overview: movie.overview),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TrailerButton(movie: movie),
      ),
    );
  }
}