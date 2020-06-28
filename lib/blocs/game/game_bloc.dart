import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ps4_collection/repositories/game_repository.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameRepository _gameRepository;

  GameBloc({
    @required GameRepository gameRepository,
}) : _gameRepository = gameRepository;

  @override
  GameState get initialState => GameState.loading();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is GameFindById) {
      yield* _mapGameFindByIdToState(event.id);
    }
  }

  Stream<GameState> _mapGameFindByIdToState(int id) async* {
    try {
      var game = (await _gameRepository.searchGameById(id)).first;

      yield GameState.success(game);
    } catch (_) {
      print("catch 1");
    }
  }
}
