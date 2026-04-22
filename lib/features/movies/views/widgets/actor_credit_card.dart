import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/person_movie_credit_model.dart';
import '../movie_details_view.dart';

class ActorCreditCard extends StatelessWidget {
  final PersonMovieCredit credit;

  const ActorCreditCard({super.key, required this.credit});

  @override
  Widget build(BuildContext context) {
    final movie = credit.movie;
    final uniqueHeroTag = 'credit_movie_${movie.id}_${credit.character}';

    return SizedBox(
      width: 140,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsView(
                movie: movie,
                heroTag: uniqueHeroTag,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: movie.posterPath.isNotEmpty
                    ? '${ApiConstants.imageBaseUrl}${movie.posterPath}'
                    : 'https://via.placeholder.com/300/1A1A29/FFFFFF/?text=No+Image',
                width: 140,
                height: 190,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 140,
                  height: 190,
                  color: AppColors.secondaryBackground,
                  child:  Center(
                    child:CupertinoActivityIndicator(
                      color: AppColors.primaryAccent,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 140,
                  height: 190,
                  color: AppColors.secondaryBackground,
                  child: const Icon(
                    Icons.broken_image_rounded,
                    color: AppColors.textSecondary,
                    size: 36,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              movie.title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              credit.character.isNotEmpty ? credit.character : 'Unknown role',
              style: TextStyle(
                // ignore: deprecated_member_use
                color: AppColors.textSecondary.withOpacity(0.8),
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
