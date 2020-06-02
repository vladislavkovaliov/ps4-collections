import 'package:ps4_collection/repositories/repositories.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ps4_collection/services/api/api.dart';

class MockGameApi extends Mock implements GameApi {}

void main() {
  GameApi gameApi;

  setUp(() {
    gameApi = MockGameApi();
  });

  group("[game_repository.dart]", () {
    group("fetchGames()", () {
      test("should return array of games", () async {
        var gameRepository = GameRepository(gameApi: gameApi);

        gameRepository.fetchGames();

        verify(gameApi.fetchGames()).called(1);
      });
    });

    group("searchGameByName()", () {
      test("should return array of games by name", () async {
        var gameRepository = GameRepository(gameApi: gameApi);

        gameRepository.searchGameByName("God of War");

        verify(gameApi.searchGameByName("God of War")).called(1);
      });
    });
  });
}
