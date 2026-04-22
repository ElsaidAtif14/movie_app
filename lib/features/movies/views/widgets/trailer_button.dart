import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import 'package:movies/core/widgets/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/movie_model.dart';

class TrailerButton extends StatefulWidget {
  final Movie movie;

  const TrailerButton({super.key, required this.movie});

  @override
  State<TrailerButton> createState() => _TrailerButtonState();
}

class _TrailerButtonState extends State<TrailerButton> {
  bool isLoading = false;

  Future<void> _launchTrailer() async {
    setState(() => isLoading = true);

    try {
      final result = await getIt<MovieRepository>().fetchMovieTrailer(widget.movie.id);

      await result.fold(
        (failure) async {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                message: failure.message,
                icon: Icons.error_outline_rounded,
              ),
            );
          }
        },
        (trailerKey) async {
          final url = Uri.parse('https://www.youtube.com/watch?v=$trailerKey');

          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.inAppWebView);
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  message: 'Could not launch trailer URL.',
                  icon: Icons.link_off_rounded,
                ),
              );
            }
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            message: 'Failed to load trailer. Please try again later.',
            icon: Icons.error_outline_rounded,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryAccent.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAccent,
          foregroundColor: AppColors.background,
          elevation: 0,
          splashFactory: NoSplash.splashFactory,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: isLoading ? null : _launchTrailer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Watch Trailer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CupertinoActivityIndicator(
                      color: Colors.black,
                      radius: 12,
                    ),
                  )
                : const Icon(Icons.play_circle_fill_rounded, size: 28),
          ],
        ),
      ),
    );
  }
}
