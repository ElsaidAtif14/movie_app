import 'package:flutter/material.dart';
import 'package:movies/features/movies/views/widgets/pagination_loader.dart';

class HomePaginationFooter extends StatelessWidget {
  final bool isLoading;
  final bool isFetchingMore;

  const HomePaginationFooter({
    super.key,
    required this.isLoading,
    required this.isFetchingMore,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Visibility(
        // بنخفي الفوتر لو لسه الصفحة بتميل لودينج لأول مرة
        visible: !isLoading,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PaginationLoader(isFetchingMore: isFetchingMore),
        ),
      ),
    );
  }
}