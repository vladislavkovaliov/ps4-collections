import 'package:ps4_collection/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthResult extends Mock implements AuthResult {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {
  String accessToken;
  String idToken;

  MockGoogleSignInAuthentication({accessToken, idToken})
      : accessToken = accessToken,
        idToken = idToken;
}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleAuthProvider extends Mock implements GoogleAuthProvider {
  static getCredential() {}
}

class MockAuthCredential extends Mock implements AuthCredential {}

class MockFirebaseUser extends Mock implements FirebaseUser {
  String email;

  MockFirebaseUser({email}) : email = email;
}

void main() {
  MockFirebaseAuth firebaseAuth;
  MockGoogleSignIn googleSignIn;
  MockAuthResult mockAuthResult;
  UserRepository userRepository;

  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    googleSignIn = MockGoogleSignIn();
    mockAuthResult = MockAuthResult();
    userRepository = UserRepository(
      firebaseAuth: firebaseAuth,
      googleSignin: googleSignIn,
    );
  });

  group("[user_repository.dart]", () {
    group("signInWithGoogle()", () {
      test("should return currentUser from FB after google auth", () async {
        var googleUser = MockGoogleSignInAccount();
        var googleSignInAuth = MockGoogleSignInAuthentication(
            accessToken: "accessToken", idToken: "idToken");
        var authCred = MockAuthCredential();
        var currentUser = new MockFirebaseUser(email: "user_email");


        when(googleSignIn.signIn())
            .thenAnswer((_) => Future<GoogleSignInAccount>.value(googleUser));

        when(googleUser.authentication).thenAnswer((_) =>
            Future<MockGoogleSignInAuthentication>.value(googleSignInAuth));

        when(firebaseAuth.signInWithCredential(authCred))
            .thenAnswer((_) => Future<MockAuthResult>.value(new MockAuthResult()));


        when(firebaseAuth.currentUser())
            .thenAnswer((_) => Future<MockFirebaseUser>.value(currentUser));

        expect(await userRepository.signInWithGoogle(), currentUser);
      });
    });

    group("signInWithCredentials()", () {
      test("should sign in with email and password", () async {
        var userRepository = UserRepository(
          firebaseAuth: firebaseAuth,
        );

        when(firebaseAuth.signInWithEmailAndPassword(
          email: "email",
          password: "password",
        )).thenAnswer((_) => Future<MockAuthResult>.value(mockAuthResult));

        userRepository.signInWithCredentials("email", "password");

        verify(firebaseAuth.signInWithEmailAndPassword(
                email: "email", password: "password"))
            .called(1);
      });
    });

    group("signUp()", () {
      test("should sign up with email and password", () async {
        when(firebaseAuth.createUserWithEmailAndPassword(
          email: "email",
          password: "password",
        )).thenAnswer((_) => Future<MockAuthResult>.value(mockAuthResult));

        userRepository.signUp(email: "email", password: "password");

        verify(firebaseAuth.createUserWithEmailAndPassword(
                email: "email", password: "password"))
            .called(1);
      });
    });

    group("getUser", () {
      test("should return email of current user", () async {
        when(firebaseAuth.currentUser()).thenAnswer((_) =>
            Future<MockFirebaseUser>.value(
                new MockFirebaseUser(email: "user_email")));

        var userEmail = await userRepository.getUser();

        expect(userEmail, "user_email");

        verify(firebaseAuth.currentUser()).called(1);
      });
    });

    group("isSignedIn()", () {
      test("should return instance of current user", () async {
        var currentUser = new MockFirebaseUser(email: "user_email");

        when(firebaseAuth.currentUser())
            .thenAnswer((_) => Future<MockFirebaseUser>.value(currentUser));

        var isSignedIn = await userRepository.isSignedIn();

        expect(isSignedIn, true);

        verify(firebaseAuth.currentUser()).called(1);
      });
    });
  });
}
