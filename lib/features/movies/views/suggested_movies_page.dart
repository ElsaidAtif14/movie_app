import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/helpers/movie_dummy_data.dart';
import 'package:movies/core/services/shared_preferences_singleton.dart';
import 'package:movies/core/utils/app_key.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/view_models/suggested_movies_cubit/suggested_movies_cubit.dart';
import 'package:movies/features/movies/view_models/suggested_movies_cubit/suggested_movies_state.dart';
import 'package:movies/features/movies/views/widgets/error_message_widget.dart';
import 'package:movies/features/movies/views/widgets/home_pagination_footer.dart';
import 'package:movies/features/movies/views/widgets/movies_grid_section.dart';

class SuggestedMoviesPage extends StatefulWidget {
  const SuggestedMoviesPage({super.key});

  @override
  State<SuggestedMoviesPage> createState() => _SuggestedMoviesPageState();
}

class _SuggestedMoviesPageState extends State<SuggestedMoviesPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    // Initialize suggested movies if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<SuggestedMoviesCubit>();
      if (cubit.state is SuggestedMoviesInitial) {
        final countryCode = Prefs.getString(AppKey.countryKey);
        if (countryCode.isNotEmpty) {
          cubit.fetchSuggestedMovies(countryCode);
        }
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<SuggestedMoviesCubit>().loadMoreSuggestedMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: false,
        automaticallyImplyActions: false,
        title: const Text(
          'Suggested for you',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
              padding: EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
        ),
      ),
      body: BlocBuilder<SuggestedMoviesCubit, SuggestedMoviesState>(
        builder: (context, state) {
          final bool isLoading =
              state is SuggestedMoviesLoading || state is SuggestedMoviesInitial;
          final List<Movie> movies = (state is SuggestedMoviesLoaded)
              ? state.movies
              : MovieDummyData.movieList;
          final bool isFetchingMore =
              state is SuggestedMoviesLoaded && state.isFetchingMore;

          if (state is SuggestedMoviesLoaded ||
              state is SuggestedMoviesLoading ||
              state is SuggestedMoviesInitial) {
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<SuggestedMoviesCubit>().refreshSuggestedMovies(),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  MoviesGridSection(isLoading: isLoading, movies: movies),
                  HomePaginationFooter(
                    isLoading: isLoading,
                    isFetchingMore: isFetchingMore,
                  ),
                ],
              ),
            );
          }

          if (state is SuggestedMoviesError) {
            return ErrorMessageWidget(message: state.message);
          }

          return const SizedBox();
        },
      ),
    );
  }
}
