import 'dart:convert';

import 'package:http/http.dart';
import 'package:ps4_collection/services/api/game_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';


void main() {
  GameApi gameApi;

  setUp(() {
    gameApi = GameApi(
      apiKey: "api_key",
    );
  });

  group("[game_api.dart]", () {
    group("fetchGames()", () {
      test("should return array of games", () async {
        gameApi.client = MockClient((request) async {
          final jsonMap = [
            {
              "id": 1,
              "name": "2",
            }
          ];

          return Response(json.encode(jsonMap), 200);
        });
        var res = await gameApi.fetchGames();

        expect(res, allOf([isList]));
        expect(res.length, allOf([isNonZero]));
      });
    });
  });
}
