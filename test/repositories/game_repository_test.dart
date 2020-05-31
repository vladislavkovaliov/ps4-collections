import 'package:ps4_collection/repositories/game_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ps4_collection/services/api/game_api.dart';

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
  });

}
