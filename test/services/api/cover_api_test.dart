import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/api.dart';
import 'package:flutter_test/flutter_test.dart';

final name = "game_name";

class MockHttpClient extends Mock implements http.Client {}

void main() {
  CoverApi coverApi;

  final API_KEY = "apikey";
  final mockHttpClient = MockHttpClient();
  final headers = {
    "user-key": API_KEY,
  };

  setUp(() {
    coverApi = CoverApi(
      httpClient: mockHttpClient,
      apiKey: API_KEY,
    );
  });

  group("[cover_api.dart]", () {
    group("fetchCovers()", () {
      test("should return array of games", () async {
        final mockCoverString = '''
          [{"url": "abc"}]
        ''';
        final json = jsonDecode(mockCoverString);
        final mockCover = (json as List).map((x) => Cover.fromJson(x)).toList();

        when(mockHttpClient.post(
          "https://api-v3.igdb.com/covers",
          headers: headers,
          body: "fields url,game;",
        )).thenAnswer(
            (_) async => Future.value(http.Response(mockCoverString, 200)));

        expect(await coverApi.fetchCovers(), mockCover);
      });
    });

    group("searchById()", () {
      test("should return array of cover instance by cover id", () async {
        final mockCoverString = '''
          [{ "id": 94113, "game": 75235, "url": "//images.igdb.com/igdb/image/upload/t_thumb/co20m9.jpg" }]
        ''';
        final json = jsonDecode(mockCoverString);
        final mockCover = (json as List).map((x) => Cover.fromJson(x)).toList();

        var cover = 94113;
        when(mockHttpClient.post(
          "https://api-v3.igdb.com/covers",
          headers: headers,
          body: "fields url,game;\n" + "where id = $cover;",
        )).thenAnswer(
            (_) async => Future.value(http.Response(mockCoverString, 200)));

        expect(await coverApi.searchById(cover), mockCover);
      });
    });
  });
}
