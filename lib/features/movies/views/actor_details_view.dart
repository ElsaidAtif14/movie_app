import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import 'package:movies/features/movies/view_models/actor_cubit/actor_cubit.dart';
import 'package:movies/features/movies/view_models/actor_cubit/actor_state.dart';
import 'package:movies/features/movies/views/widgets/actor_alias_list.dart';
import 'package:movies/features/movies/views/widgets/actor_biography.dart';
import 'package:movies/features/movies/views/widgets/actor_details_app_bar.dart';
import 'package:movies/features/movies/views/widgets/actor_modern_info_grid.dart';
import 'package:movies/features/movies/views/widgets/actor_movies_section.dart';

class ActorDetailsView extends StatelessWidget {
  final int actorId;
  final String heroTag;

  const ActorDetailsView({
    super.key,
    required this.actorId,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ActorCubit(getIt<MovieRepository>())..loadActor(actorId),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<ActorCubit, ActorState>(
          builder: (context, state) {
            if (state is ActorLoading) return _buildLoading();
            if (state is ActorError) return _buildError(state.message);
            if (state is ActorLoaded) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  ActorDetailsAppBar(actor: state.actor, heroTag: heroTag),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ActorModernInfoGrid(
                            actor: state.actor,
                          ), // الويجت الجديدة
                          if (state.actor.alsoKnownAs.isNotEmpty)
                            ActorAliasList(aliases: state.actor.alsoKnownAs),
                          ActorBiography(bio: state.actor.biography),
                          const ActorMoviesSection(), // فصلنا قسم الأفلام
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(
    child: CupertinoActivityIndicator(color: AppColors.primaryAccent,)
  );

  Widget _buildError(String message) => Center(
    child: Text(message, style: const TextStyle(color: Colors.red)),
  );

  
}
