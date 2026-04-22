import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_colors.dart';

class PaginationLoader extends StatelessWidget {
  final bool isFetchingMore;

  const PaginationLoader({super.key, required this.isFetchingMore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Visibility(
        visible: isFetchingMore,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Center(
          child: CupertinoActivityIndicator(color: AppColors.primaryAccent),
        ),
      ),
    );
  }
}
