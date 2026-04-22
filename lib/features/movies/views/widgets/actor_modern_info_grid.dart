import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_colors.dart';

class ActorModernInfoGrid extends StatelessWidget {
  final dynamic actor; // استبدله بنوع الموديل بتاعك

  const ActorModernInfoGrid({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _ModernInfoItem(
            icon: Icons.work_outline,
            label: 'Dept',
            value: actor.knownForDepartment,
          ),
          _ModernInfoItem(
            icon: Icons.cake_outlined,
            label: 'Born',
            value: actor.birthday,
          ),
          _ModernInfoItem(
            icon: Icons.location_on_outlined,
            label: 'From',
            value: actor.placeOfBirth,
          ),
          _ModernInfoItem(
            icon: Icons.person_outline,
            label: 'Gender',
            value: actor.genderText,
          ),
        ],
      ),
    );
  }
}

class _ModernInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ModernInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 180),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: AppColors.secondaryBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primaryAccent),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    // ignore: deprecated_member_use
                    color: AppColors.textSecondary.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
