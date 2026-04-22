import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/features/movies/view_models/movies_cubit/movies_cubit.dart';
import 'package:movies/features/movies/view_models/movies_cubit/movies_state.dart';

class CustomSliverAppBar extends StatelessWidget {
  final void Function()? onPressed;
  const CustomSliverAppBar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          // ignore: deprecated_member_use
          child: Container(color: AppColors.background.withOpacity(0.5)),
        ),
      ),
      title: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          final cubit = context.read<MoviesCubit>();
          final categoryTitle =
              cubit.categories[cubit.selectedCategoryIndex]['title']!;

          return Text(
            categoryTitle,

            style: const TextStyle(
              fontFamily: 'Oswald',
              color: AppColors.primaryAccent,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          );
        },
      ),
      // actions: [
      //   Container(
      //     margin: const EdgeInsets.only(right: 16),
      //     decoration: BoxDecoration(
      //       // ignore: deprecated_member_use
      //       color: Colors.white.withOpacity(0.1),
      //       shape: BoxShape.circle,
      //       // ignore: deprecated_member_use
      //       border: Border.all(color: Colors.white.withOpacity(0.2)),
      //     ),
      //     child: IconButton(
      //       icon: const Icon(Icons.search, color: AppColors.textPrimary),
      //       onPressed: onPressed,
      //     ),
      //   ),
      
    );
  }
}
