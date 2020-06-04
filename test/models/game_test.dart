import 'package:flutter_test/flutter_test.dart';
import "package:ps4_collection/models/models.dart";

void main() {
  group("models/game.dart", () {
    group("static mapGenres()", () {
      test("should return []", () {
        expect(Game.mapGenres(null), []);
      });

      test("should convert dynamic array to List", () {
        expect(Game.mapGenres([1, 2, 3, 4, 5] as dynamic), [1, 2, 3, 4, 5]);
      });
    });
  });
}
