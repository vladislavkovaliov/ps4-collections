import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps4_collection/delegates/simple_bloc_delegate.dart';
import 'package:ps4_collection/models/game.dart';
import 'package:ps4_collection/repositories/game_repository.dart';
import 'package:ps4_collection/repositories/user_repository.dart';
import 'package:ps4_collection/routes/routes.dart';

import 'blocs/authentication/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final UserRepository userRepository = UserRepository();
  final GameRepository gameRepository = GameRepository();

  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child:
          App(userRepository: userRepository, gameRepository: gameRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final GameRepository _gameRepository;

  App(
      {Key key,
      @required UserRepository userRepository,
      @required GameRepository gameRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _gameRepository = gameRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF192229),
        primaryColor: Color(0xFF192229),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return Splash();
          }

          if (state is Authenticated) {
            return Home(name: state.displayName);
          }

          if (state is Unauthenticated) {
            return SignIn(userRepository: _userRepository);
          }

          return Container();
        },
      ),
      initialRoute: '/gameDescription',
      routes: {
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
        '/home': (context) => Home(),
        '/gameDescription': (context) => GameDescription(
              gameRepository: _gameRepository,
            ),
      },
    );
  }
}
