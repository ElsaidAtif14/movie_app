import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/cast_model.dart';
import '../../view_models/cast_cubit/cast_cubit.dart';
import '../../view_models/cast_cubit/cast_state.dart';
import 'cast_card.dart';

class MovieCastSection extends StatelessWidget {
  const MovieCastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Cast',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TopCastBlocBuilder(),
      ],
    );
  }
}

class TopCastBlocBuilder extends StatelessWidget {
  const TopCastBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastCubit, CastState>(
      builder: (context, state) {
        if (state is CastLoading) {
          return SizedBox(
            height: 200,
            child: Skeletonizer(
              enabled: true,
              effect: ShimmerEffect(
                baseColor: Colors.grey[900]!,
                highlightColor: Colors.grey[600]!,
                duration: const Duration(seconds: 1),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                padding: const EdgeInsets.only(left: 16),
                itemBuilder: (context, index) {
                  return CastCard(actor: _buildDummyActor(index));
                },
              ),
            ),
          );
        } else if (state is CastLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.cast.length,
              itemBuilder: (context, index) {
                final actor = state.cast[index];
                return CastCard(actor: actor);
              },
            ),
          );
        } else if (state is CastError) {
          return Text(
            state.message,
            style: const TextStyle(color: Colors.red),
          );
        }
        return const SizedBox();
      },
    );
  }

  Cast _buildDummyActor(int index) {
    return Cast(
      id: index,
      name: '',
      profilePath: '',
      character: '',
    );
  }
}
