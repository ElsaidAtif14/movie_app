import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/features/movies/views/suggested_movies_page.dart';

class SuggestedMoviesHeader extends StatelessWidget {
  const SuggestedMoviesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Suggested for you',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SuggestedMoviesPage(),
                ),
              ),
              child: const Text(
                'See More',
                style: TextStyle(
                  color: AppColors.primaryAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
