import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/game_api.dart';
import 'package:flutter_test/flutter_test.dart';

final name = "game_name";

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

    when(searchGameByName(name)).thenAnswer((_) {
      return _real.searchGameByName(name);
    });
  }
}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final mockHttpClient = MockHttpClient();
  final mockGameApi = MockGameApi(mockHttpClient);
  final headers = {
    "user-key": "api_key",
  };

  group("[game_api.dart]", () {
    group("fetchGames()", () {
      test("should return array of games:skip", () async {
        var realGameApi = GameApi(
          httpClient: http.Client(),
          apiKey: ""
        );
        var res = await realGameApi.fetchGames();

        print(res);
      }, skip: true);

      test("should return array of games", () async {
        final mockGameString = '''
          [{"id": 123, "name": "abc", "genres": []}]
        ''';
        final json = jsonDecode(mockGameString);
        final mockGame = (json as List).map((x) => Game.fromJson(x)).toList();

        when(mockHttpClient
          .post(
            "https://api-v3.igdb.com/games",
            headers: headers,
            body: "fields name,genres;",
          ))
          .thenAnswer((_) async => Future.value(http.Response(mockGameString, 200)));

        expect(await mockGameApi.fetchGames(), mockGame);
      });
    });

    group("searchGameByName()", () {
      test("should return array of games", () async {
        final mockGameString = '''
          [{"id": 123, "name": "abc", "genres": []}]
        ''';
        final json = jsonDecode(mockGameString);
        final mockGame = (json as List).map((x) => Game.fromJson(x)).toList();
        final body = "fields name,genres;\n" +
                     'search "$name";';

        when(mockHttpClient
            .post(
            "https://api-v3.igdb.com/games",
            headers: headers,
            body: body,
          ))
          .thenAnswer((_) async => Future.value(http.Response(mockGameString, 200)));

        expect(await mockGameApi.searchGameByName(name), mockGame);
      });

      test("should return array of games without genres", () async {
        final mockGameString = '''
          [{"id": 123, "name": "abc"}]
        ''';
        final json = jsonDecode(mockGameString);
        final mockGame = (json as List).map((x) => Game.fromJson(x)).toList();
        final body = "fields name,genres;\n" +
            'search "$name";';

        when(mockHttpClient
            .post(
          "https://api-v3.igdb.com/games",
          headers: headers,
          body: body,
        ))
            .thenAnswer((_) async => Future.value(http.Response(mockGameString, 200)));

        expect(await mockGameApi.searchGameByName(name), mockGame);
      });
    });
  });
}
