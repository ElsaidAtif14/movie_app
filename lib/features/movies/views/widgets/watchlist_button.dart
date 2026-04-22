import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/widgets/custom_snackbar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/movie_model.dart';
import '../../../watchlist/view_models/watchlist_cubit.dart';
import '../../../watchlist/view_models/watchlist_state.dart';

class WatchlistButton extends StatelessWidget {
  final Movie movie;

  const WatchlistButton({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      builder: (context, state) {
        final isSaved = state.savedMovies.any((m) => m.id == movie.id);

        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: isSaved ? AppColors.primaryAccent : Colors.white,
            ),
            onPressed: () {
              context.read<WatchlistCubit>().toggleWatchlist(movie);

              Future.microtask(() {
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    message: isSaved
                        ? 'Removed from Watchlist'
                        : 'Added to Watchlist',
                  ),
                );
              });
            },
          ),
        );
      },
    );
  }
}
