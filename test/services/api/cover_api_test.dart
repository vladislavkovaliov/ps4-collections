import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/api.dart';
import 'package:flutter_test/flutter_test.dart';

final name = "game_name";

class MockCoverApi extends Mock implements CoverApi {
  CoverApi _real;

  MockCoverApi(http.Client httpClient) {
    _real = CoverApi(
        apiKey: "api_key",
        httpClient: httpClient
    );

    when(fetchCovers()).thenAnswer((_) {
      return _real.fetchCovers();
    });
  }
}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  CoverApi coverApi;

  final mockHttpClient = MockHttpClient();
  final mockCoverApi = MockCoverApi(mockHttpClient);
  final headers = {
    "user-key": "api_key",
  };

  setUp(() {
    coverApi = CoverApi(
      httpClient: http.Client(),
      apiKey: "api_key",
    );

  });

  group("[cover_api.dart]", () {
    group("fetchCovers()", () {
      test("should return array of covers:skip", () async {
        var res = await coverApi.fetchCovers();
        print(res);
      }, skip: true);

      test("should return array of games", () async {
        final mockCoverString = '''
          [{"url": "abc"}]
        ''';
        final json = jsonDecode(mockCoverString);
        final mockCover = (json as List).map((x) => Cover.fromJson(x)).toList();

        when(mockHttpClient
            .post(
          "https://api-v3.igdb.com/covers",
          headers: headers,
          body: "fields url;",
        ))
          .thenAnswer((_) async => Future.value(http.Response(mockCoverString, 200)));

        expect(await mockCoverApi.fetchCovers(), mockCover);
      });
    });
  });
}
