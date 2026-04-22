// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../view_models/movies_cubit/movies_cubit.dart';
import '../../view_models/movies_cubit/movies_state.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoviesCubit>();

    return SizedBox(
      height: 55,
      child: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          final selectedIndex = cubit.selectedCategoryIndex;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cubit.categories.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  if (!isSelected) {
                    cubit.fetchMovies(index);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(right: 12, bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              AppColors.primaryAccent.withOpacity(0.8),
                              AppColors.primaryAccent.withOpacity(0.7),
                              AppColors.primaryAccent.withOpacity(0.6),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected
                        ? null
                        : AppColors.secondaryBackground.withOpacity(0.2),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: AppColors.primaryAccent.withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: -1,
                          offset: const Offset(0, 2),
                        ),
                    ],
                    border: Border.all(
                      color: isSelected
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white.withOpacity(0.05),
                      width: 0.8,
                    ),
                  ),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.black
                            : AppColors.textPrimary.withOpacity(0.7),
                        fontSize: 15,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                      child: Text(cubit.categories[index]['title']!),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
