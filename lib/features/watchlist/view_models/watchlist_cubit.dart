import 'package:flutter_bloc/flutter_bloc.dart';
import '../../movies/models/movie_model.dart';
import 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistState([]));

  void toggleWatchlist(Movie movie) {
    final currentList = List<Movie>.from(state.savedMovies);
    
    final isExist = currentList.any((element) => element.id == movie.id);
    
    if (isExist) {
      currentList.removeWhere((element) => element.id == movie.id);
    } else {
      currentList.add(movie);
    }
    
    emit(WatchlistState(currentList));
  }

  bool isSaved(int movieId) {
    return state.savedMovies.any((element) => element.id == movieId);
  }
}