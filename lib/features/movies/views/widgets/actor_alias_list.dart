import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_colors.dart';

class ActorAliasList extends StatelessWidget {
  final List<String> aliases;

  const ActorAliasList({super.key, required this.aliases});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Also known as',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: aliases.map((alias) => _buildAliasTag(alias)).toList(),
        ),
      ],
    );
  }

  Widget _buildAliasTag(String alias) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: AppColors.secondaryBackground.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Text(
        alias,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}