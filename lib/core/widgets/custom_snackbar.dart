import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_colors.dart';

SnackBar customSnackBar({
  required String message,
  IconData icon = Icons.info_outline_rounded,
  Color? backgroundColor,
}) {
  return SnackBar(
    backgroundColor: Colors
        .transparent, // بنخلي الخلفية شفافة عشان نستخدم الـ Container بتاعنا
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.fromLTRB(
      20,
      0,
      20,
      20,
    ), // رفعه عن الأرض وعن الجوانب
    duration: const Duration(milliseconds: 800), // مدة ظهور الـ SnackBar
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryAccent,
        borderRadius: BorderRadius.circular(
          16,
        ), // حواف دائرية أكتر (Modern Look)
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: (backgroundColor ?? AppColors.primaryAccent).withOpacity(
              0.3,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
