import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/services/custom_bloc_observer.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/core/services/shared_preferences_singleton.dart';
import 'package:movies/features/splach/views/splach_view.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import 'package:movies/features/movies/view_models/suggested_movies_cubit/suggested_movies_cubit.dart';
import 'core/theme/app_theme.dart';
import 'features/watchlist/view_models/watchlist_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  await Prefs.init();
  Bloc.observer = CustomBlocObserver();

   runApp(
    const MovieApp(),
   );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WatchlistCubit(),
        ),
      
        BlocProvider(
          create: (context) => SuggestedMoviesCubit(getIt<MovieRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Movie',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const SplachView(),
      ),
    );
  }
}
