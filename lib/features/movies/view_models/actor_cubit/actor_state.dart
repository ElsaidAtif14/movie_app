import '../../models/person_movie_credit_model.dart';
import '../../models/person_model.dart';

abstract class ActorState {}

class ActorInitial extends ActorState {}

class ActorLoading extends ActorState {}

class ActorLoaded extends ActorState {
  final Person actor;
  final List<PersonMovieCredit> credits;

  ActorLoaded(this.actor, this.credits);
}

class ActorError extends ActorState {
  final String message;

  ActorError(this.message);
}
