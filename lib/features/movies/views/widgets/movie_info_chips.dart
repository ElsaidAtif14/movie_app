import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class MovieInfoChips extends StatelessWidget {
  final String year;

  const MovieInfoChips({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildInfoChip(Icons.calendar_month_rounded, year),
        const SizedBox(width: 16),
        _buildInfoChip(Icons.language_rounded, 'EN'),
        const SizedBox(width: 16),
        _buildInfoChip(Icons.high_quality_rounded, '4K'),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 16),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
