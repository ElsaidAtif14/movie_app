import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/views/widgets/home_view_body.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import '../view_models/movies_cubit/movies_cubit.dart';
import '../view_models/suggested_movies_cubit/suggested_movies_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesCubit(getIt<MovieRepository>())..fetchMovies(),
        ),
        BlocProvider(
          create: (context) => SuggestedMoviesCubit(getIt<MovieRepository>()),
        ),
      ],
      child: const HomeViewBody(),
    );
  }
}
