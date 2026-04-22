import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constants/app_colors.dart';
import 'package:movies/features/movies/view_models/actor_cubit/actor_cubit.dart';
import 'package:movies/features/movies/view_models/actor_cubit/actor_state.dart';
import 'package:movies/features/movies/views/widgets/actor_credit_card.dart';

class ActorMoviesSection extends StatelessWidget {
  const ActorMoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ActorCubit>().state;
    if (state is! ActorLoaded || state.credits.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Divider(color: AppColors.secondaryBackground, thickness: 2),
        const SizedBox(height: 24),
        const Text('Featured Movies', 
          style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: state.credits.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) => ActorCreditCard(credit: state.credits[index]),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}