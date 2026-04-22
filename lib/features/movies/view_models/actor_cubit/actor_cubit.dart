import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';

import 'actor_state.dart';

class ActorCubit extends Cubit<ActorState> {
  final MovieRepository repository;

  ActorCubit(this.repository) : super(ActorInitial());

  Future<void> loadActor(int actorId) async {
    emit(ActorLoading());

    final actorResult = await repository.fetchPersonDetails(actorId);
    await actorResult.fold(
      (failure) async {
        emit(ActorError(failure.message));
      },
      (actor) async {
        final creditsResult = await repository.fetchPersonMovieCredits(actorId);

        creditsResult.fold(
          (_) => emit(ActorLoaded(actor, [])),
          (credits) => emit(ActorLoaded(actor, credits)),
        );
      },
    );
  }
}
