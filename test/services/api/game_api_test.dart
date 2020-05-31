import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/game_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

class MockGameApi extends Mock implements GameApi {
  GameApi _real;

  MockGameApi(http.Client httpClient) {
    _real = GameApi(
      apiKey: "api_key",
      httpClient: httpClient
    );

    when(fetchGames()).thenAnswer((_) {
      return _real.fetchGames();
    });
  }
}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  GameApi gameApi;

  setUp(() {
    gameApi = GameApi(
      apiKey: "api_key",
    );
  });

  group("[game_api.dart]", () {

    group("fetchGames()", () {
      test("should return array of games:skip", () async {
        var res = await gameApi.fetchGames();
        print(res);
      }, skip: true);

      test("should return array of games", () async {
        final mockHttpClient = MockHttpClient();
        final mockGameApi = MockGameApi(mockHttpClient);
        final mockGameString = '''
          [{"id": 123, "name": "abc"}]
        ''';
        final json = jsonDecode(mockGameString);
        final mockGame = (json as List).map((x) => Game.fromJson(x)).toList();
        final headers = {
          "user-key": "api_key",
        };

        when(mockHttpClient
          .post(
            "https://api-v3.igdb.com/games",
            headers: headers,
            body: "fields name;",
          ))
          .thenAnswer(
              (_) async {
                return Future.value(http.Response(mockGameString, 200));
              });

        expect(await mockGameApi.fetchGames(), mockGame);

      });
    });
  });
}
