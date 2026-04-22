import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'widgets/profile_header.dart';
import 'widgets/stats_section.dart';
import 'widgets/settings_section.dart';
import 'widgets/logout_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              ProfileHeader(),
              SizedBox(height: 32),
              StatsSection(),
              SizedBox(height: 32),
              SettingsSection(),
              SizedBox(height: 24),
              LogoutButton(),
              SizedBox(height: screenHeight*0.2), // إضافة مساحة في الأسفل
            ],
          ),
        ),
      ),
    );
  }
}
