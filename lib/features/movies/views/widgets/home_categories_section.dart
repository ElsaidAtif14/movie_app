import 'package:flutter/material.dart';
import 'package:movies/features/movies/views/widgets/category_tabs.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: CategoryTabs(),
      ),
    );
  }
}