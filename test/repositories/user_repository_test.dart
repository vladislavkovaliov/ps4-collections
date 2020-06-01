import 'package:ps4_collection/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ps4_collection/services/api/game_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthResult extends Mock implements AuthResult {}

void main() {
  group("[user_repository.dart]", () {
    group("signInWithCredentials()", () {
      test("should return array of games", () async {
        MockFirebaseAuth firebaseAuth = MockFirebaseAuth();

        final MockAuthResult mockAuthResult = MockAuthResult();

        var userRepository = UserRepository(
          firebaseAuth: firebaseAuth,
        );

        when(firebaseAuth.signInWithEmailAndPassword(
          email: "email",
          password: "password",
        )).thenAnswer((_) => Future<MockAuthResult>.value(mockAuthResult));

        userRepository.signInWithCredentials("email", "password");

        verify(userRepository.signInWithCredentials("email", "password"))
            .called(1);
      });
    });
  });
}
