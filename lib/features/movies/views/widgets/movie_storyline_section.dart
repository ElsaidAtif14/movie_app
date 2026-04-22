import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class MovieStorylineSection extends StatelessWidget {
  final String overview;

  const MovieStorylineSection({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Storyline',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          overview,
          style: TextStyle(
            // ignore: deprecated_member_use
            color: AppColors.textSecondary.withOpacity(0.8),
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
