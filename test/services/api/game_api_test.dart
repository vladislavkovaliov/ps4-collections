import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/game_api.dart';
import 'package:flutter_test/flutter_test.dart';

final name = "game_name";

class MockHttpClient extends Mock implements http.Client {}

void main() {
  final API_KEY = "apikey";
  final mockHttpClient = MockHttpClient();
  final headers = {
    "user-key": API_KEY,
  };

  GameApi gameApi;

  setUp(() {
    gameApi = GameApi(
      httpClient: mockHttpClient,
      apiKey: API_KEY,
    );
  });

  group("[game_api.dart]", () {
    group("fetchGames()", () {
      test("should return array of games", () async {
        final mockGameString = '''
          [{"id": 123, "name": "abc", "genres": []}]
        ''';
        final json = jsonDecode(mockGameString);
        final mockGame = (json as List).map((x) => Game.fromJson(x)).toList();

        when(mockHttpClient.post(
          "https://api-v3.igdb.com/games",
          headers: headers,
          body: "fields name,genres,cover;",
        )).thenAnswer(
            (_) async => Future.value(http.Response(mockGameString, 200)));

        expect(await gameApi.fetchGames(), mockGame);
      });
    });

    group("searchGameByName()", () {
      test("should return array of games", () async {
        final mockGameString = '''
          [{"id": 123, "name": "abc", "genres": []}]
        ''';
        final json = jsonDecode(mockGameString);
        final mockGame = (json as List).map((x) => Game.fromJson(x)).toList();
        final body = "fields name,genres,cover;\n" + 'search "$name";';

        when(mockHttpClient.post(
          "https://api-v3.igdb.com/games",
          headers: headers,
          body: body,
        )).thenAnswer(
            (_) async => Future.value(http.Response(mockGameString, 200)));

        expect(await gameApi.searchGameByName(name), mockGame);
      });

      test("should return array of games without genres", () async {
        final mockGameString = '''
          [{"id": 123, "name": "abc"}]
        ''';
        final json = jsonDecode(mockGameString);
        final mockGame = (json as List).map((x) => Game.fromJson(x)).toList();
        final body = "fields name,genres;\n" + 'search "$name";';

        when(mockHttpClient.post(
          "https://api-v3.igdb.com/games",
          headers: headers,
          body: body,
        )).thenAnswer(
            (_) async => Future.value(http.Response(mockGameString, 200)));

        expect(await gameApi.searchGameByName(name), mockGame);
      });
    });
  });
}
