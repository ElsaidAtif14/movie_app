import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/cast_model.dart';
import '../actor_details_view.dart';

class CastCard extends StatelessWidget {
  final Cast actor;

  const CastCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    final heroTag = 'actor_${actor.id}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ActorDetailsView(actorId: actor.id, heroTag: heroTag),
          ),
        );
      },
      child: Container(
        width: 100,

        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: CachedNetworkImage(
                  imageUrl: actor.profilePath.isNotEmpty
                      ? '${ApiConstants.imageBaseUrl}${actor.profilePath}'
                      : 'https://via.placeholder.com/150/1A1A29/FFFFFF/?text=Actor',
                  width: 100,
                  height: 120,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(
                    color: AppColors.secondaryBackground,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        color: AppColors.primaryAccent,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.secondaryBackground,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              actor.name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              actor.character,
              style: TextStyle(
                // ignore: deprecated_member_use
                color: AppColors.textSecondary.withOpacity(0.7),
                fontSize: 10,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
