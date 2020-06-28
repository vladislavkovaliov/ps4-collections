import 'package:equatable/equatable.dart';
import 'package:ps4_collection/models/models.dart';

abstract class GameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GameLoaded extends GameEvent {}

class GameLoading extends GameEvent {}

class GameFindById extends GameEvent {
  int id;

  GameFindById({ this.id });
}
