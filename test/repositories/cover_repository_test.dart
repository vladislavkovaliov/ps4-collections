import 'package:ps4_collection/repositories/repositories.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ps4_collection/services/api/api.dart';

class MockCoverApi extends Mock implements CoverApi {}

void main() {
  CoverApi coverApi;

  setUp(() {
    coverApi = MockCoverApi();
  });

  group("[cover_repository.dart]", () {
    group("fetchGames()", () {
      test("should return array of games", () async {
        var coverRepository = CoverRepository(coverApi: coverApi);

        await coverRepository.fetchCovers();

        verify(coverApi.fetchCovers()).called(1);
      });
    });
  });
}
