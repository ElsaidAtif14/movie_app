import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/watchlist/view_models/watchlist_cubit.dart';
import 'package:movies/features/watchlist/view_models/watchlist_state.dart';
import '../../../../core/constants/app_colors.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatItem('Watched', '42', Icons.play_circle_fill),
        const SizedBox(width: 16),
        BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            return _buildStatItem(
              'Watchlist',
              state.savedMovies.length.toString(),
              Icons.bookmark_rounded,
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: AppColors.secondaryBackground.withOpacity(0.4),
          borderRadius: BorderRadius.circular(24),
          // ignore: deprecated_member_use
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryAccent),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
