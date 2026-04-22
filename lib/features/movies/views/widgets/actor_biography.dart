import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_colors.dart';

class ActorBiography extends StatelessWidget {
  final String bio;
  const ActorBiography({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text('Biography', 
          style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(
          bio.isEmpty ? 'No biography available.' : bio,
          style: TextStyle(
            // ignore: deprecated_member_use
            color: AppColors.textSecondary.withOpacity(0.85),
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}