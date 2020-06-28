import 'package:meta/meta.dart';
import 'package:ps4_collection/models/game.dart';

@immutable
class GameState {
  final bool isLoading;
  final Game game;

  GameState({
    @required this.game,
    @required this.isLoading,
  });

  GameState update({
    bool isLoading,
    Game game,
  }) {
    return copyWith(
      isLoading: isLoading,
      game: game,
    );
  }

  GameState copyWith({
    bool isLoading,
    Game game,
  }) {
    return GameState(
      isLoading: isLoading,
      game: game,
    );
  }

  factory GameState.loading() {
    return GameState(
      isLoading: true,
      game: null,
    );
  }

  factory GameState.success(Game game) {
    return GameState(
      isLoading: false,
      game: game,
    );
  }
}
