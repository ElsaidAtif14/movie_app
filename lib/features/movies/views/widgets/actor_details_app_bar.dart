import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/person_model.dart';

class ActorDetailsAppBar extends StatelessWidget {
  final Person actor;
  final String heroTag;

  const ActorDetailsAppBar({
    super.key,
    required this.actor,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SliverAppBar(
      expandedHeight: screenHeight * 0.65,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.background,
      elevation: 0,

      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Padding(
            padding: EdgeInsets.only(right: 2.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          actor.name,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontFamily: 'Oswald',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        stretchModes: const [StretchMode.zoomBackground],
        background: Hero(
          tag: heroTag,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: actor.profilePath.isNotEmpty
                    ? '${ApiConstants.imageBaseUrl}${actor.profilePath}'
                    : 'https://via.placeholder.com/600/1A1A29/FFFFFF/?text=Actor',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryAccent,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      AppColors.background,
                    ],
                    stops: [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
