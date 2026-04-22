import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/constants/assets.dart';
import 'package:movies/features/profile/views/profile_view.dart';
import 'package:movies/features/watchlist/views/watchlist_view.dart';
import 'package:movies/features/search/views/search_view.dart';
import '../../../../core/constants/app_colors.dart';
import 'home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  // قائمة الشاشات الخاصة بالتطبيق
  final List<Widget> _screens = [
    const HomeView(),
    const SearchView(showBackButton: false),
    const WatchlistView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // لجعل المحتوى يظهر خلف الـ Bottom Bar الشفاف
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildGlassBottomNavBar(),
    );
  }

  Widget _buildGlassBottomNavBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        24,
        0,
        24,
        10,
      ), // مسافات من الجوانب ومن الأسفل
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // تأثير التغبيش
          child: Container(
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.secondaryBackground.withOpacity(0.4),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.1),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Assets.assetsBottomNavIconHome, 0),
                _buildNavItem(Assets.assetsBottomNavIconCompass, 1),
                _buildNavItem(Assets.assetsBottomNavIconBookmar, 2),
                _buildNavItem(Assets.assetsBottomNavIconPerson, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgPath, int index) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(0, isSelected ? -6 : 0, 0),
              child: SvgPicture.asset(
                svgPath,
                height: isSelected ? 24 : 22,
                width: isSelected ? 24 : 22,
                // ignore: deprecated_member_use
                color: isSelected
                    ? AppColors.primaryAccent
                    : AppColors.textSecondary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 4,
              width: isSelected ? 14 : 0,
              decoration: BoxDecoration(
                color: AppColors.primaryAccent,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: AppColors.primaryAccent.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
