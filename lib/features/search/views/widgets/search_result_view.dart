import 'package:flutter/material.dart';
import 'package:movies/features/movies/models/movie_model.dart';
import 'package:movies/features/movies/views/widgets/movies_sliver_grid.dart';
import '../../../../../core/constants/app_colors.dart';

class SearchResultView extends StatelessWidget {
  final List<Movie> movies; // استبدلها بموديل الفيلم بتاعك
  final bool isLoading;
  const SearchResultView({super.key, required this.movies, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(child: Text("No results found 🔍", style: TextStyle(color: AppColors.textSecondary)));
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Text('Search Results', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text('${movies.length} found', style: const TextStyle(color: AppColors.primaryAccent, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        MoviesSliverGrid(movies: movies, isLoading: isLoading),
        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }
}