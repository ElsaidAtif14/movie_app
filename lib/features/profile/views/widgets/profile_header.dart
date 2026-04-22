import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primaryAccent, Colors.blueAccent],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryAccent.withOpacity(0.3),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/memoji-emoji-handsome-smiling-man-white-background_826801-6987.jpg'),
              ),
            ),
            // أيقونة تعديل صغيرة (إضافة جمالية)
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.background,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.primaryAccent,
                child: Icon(Icons.edit, size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Elsaid Atif',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        Text(
          'elsaidatif9@gmail.com',
          style: TextStyle(color: AppColors.textSecondary, letterSpacing: 0.5),
        ),
      ],
    );
  }
}