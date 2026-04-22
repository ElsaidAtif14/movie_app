import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/helpers/movie_dummy_data.dart';
import 'package:movies/core/services/shared_preferences_singleton.dart';
import 'package:movies/core/utils/app_key.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/view_models/movies_cubit/movies_cubit.dart';
import 'package:movies/features/movies/view_models/movies_cubit/movies_state.dart';
import 'package:movies/features/movies/view_models/suggested_movies_cubit/suggested_movies_cubit.dart';
import 'package:movies/features/movies/views/widgets/custom_sliver_app_bar.dart';
import 'package:movies/features/movies/views/widgets/custom_header.dart';
import 'package:movies/features/movies/views/widgets/error_message_widget.dart';
import 'package:movies/features/movies/views/widgets/home_carousel_section.dart';
import 'package:movies/features/movies/views/widgets/home_categories_section.dart';
import 'package:movies/features/movies/views/widgets/home_pagination_footer.dart';
import 'package:movies/features/movies/views/widgets/movies_grid_section.dart';
import 'package:movies/features/movies/views/widgets/suggested_movies_list_view.dart';
import 'package:movies/features/movies/views/widgets/suggested_movies_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    // استدعاء الـ Suggested movies بعد انتهاء البناء الأول
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final countryCode = Prefs.getString(AppKey.countryKey);
      context.read<SuggestedMoviesCubit>().fetchSuggestedMovies(countryCode);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<MoviesCubit>().loadMoreMovies();
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
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          final bool isLoading =
              state is MoviesLoading || state is MoviesInitial;
          final List<Movie> movies = (state is MoviesLoaded)
              ? state.movies
              : MovieDummyData.movieList;
          final bool isFetchingMore =
              state is MoviesLoaded && state.isFetchingMore;
          if (state is MoviesLoaded ||
              state is MoviesLoading ||
              state is MoviesInitial) {
            return RefreshIndicator(
              onRefresh: () => context.read<MoviesCubit>().refreshMovies(),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  CustomSliverAppBar(),
                  HomeCarouselSection(isLoading: isLoading, movies: movies),
                  const HomeCategoriesSection(),
                  SuggestedMoviesHeader(),
                  SuggestedMoviesListView(),
                  const CustomHeader(title: 'Discover'),
                  MoviesGridSection(isLoading: isLoading, movies: movies),
                  HomePaginationFooter(
                    isLoading: isLoading,
                    isFetchingMore: isFetchingMore,
                  ),
                ],
              ),
            );
          }
          if (state is MoviesError) {
            return ErrorMessageWidget(message: state.message);
          }
          return SizedBox();
        },
      ),
    );
  }
}
