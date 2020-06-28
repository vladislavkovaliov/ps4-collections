import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps4_collection/blocs/authentication/bloc.dart';
import 'package:ps4_collection/blocs/game/bloc.dart';
import 'package:ps4_collection/repositories/game_repository.dart';

class GameDescription extends StatefulWidget {
  final String name;
  final GameRepository _gameRepository;

  GameDescription({this.name, GameRepository gameRepository})
      : _gameRepository = gameRepository;

  @override
  _GameDescriptionState createState() => _GameDescriptionState();
}

class _GameDescriptionState extends State<GameDescription> {
  Future<bool> completed;

  GameRepository get _gameRepository => widget._gameRepository;

  Future<bool> loadData() async {
    await Future.delayed(Duration(seconds: 3));

    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Game Description'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      body: BlocProvider<GameBloc>(
        create: (context) => GameBloc(gameRepository: _gameRepository),
        child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
          print(state.game);
          return Column(
            children: [
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<GameBloc>(context).add(GameFindById(id: 551));
                },
              ),
              if (state.game != null) Expanded(
                child: ListView(children: <Widget>[
                  Container(
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: 264,
                          width: 184,
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(state.game.cover.url),
                            )
                          ),
                        ),
                        for (var screenshot in state.game.screenshots) Container(
                          margin: EdgeInsets.only(left: 20, right: screenshot == state.game.screenshots.last ? 16 : 0),
                          height: 264,
                          width: 368,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(screenshot),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  GameSpecialList(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.game != null ? state.game.name : '',
                        style: TextStyle(fontSize: 29, color: Color(0xFFFEFEFE)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      state.game != null ? state.game.summary : '',
                      style: TextStyle(
                        color: Color(0xFFFEFEFE),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ]),
              ) else Center(child: CircularProgressIndicator())
            ],
          );
        }),
      ),
    );
  }
}

class GameSpecialList extends StatelessWidget {
  const GameSpecialList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> specialList = [
      {"value": "8.9", "text": "RATING"},
      {
        "value": "1-3",
        "text": "PLAYERS",
      },
      {
        "value": "1-3",
        "text": "PLAYERS",
      },
      {
        "value": "28",
        "text": "COMMENTS",
      },
    ];

    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: specialList.map((e) {
          return SpecialItem(
            value: e["value"],
            text: e["text"],
            isLast: specialList.last == e,
            isFirst: specialList.first == e,
          );
        }).toList(),
      ),
    );
  }
}

class SpecialItem extends StatelessWidget {
  final String value;
  final String text;

  final bool isLast;
  final bool isFirst;

  const SpecialItem({
    Key key,
    this.text,
    this.value,
    this.isLast,
    this.isFirst,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                this.value,
                style: TextStyle(fontSize: 28, color: Color(0xFFFEFEFE)),
              ),
              Text(
                this.text.toUpperCase(),
                style: TextStyle(fontSize: 19, color: Color(0xFFFEFEFE)),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          width: this.isLast ? 0 : 2,
          color: Color(0xFF353A3E),
        ),
      ],
    );
  }
}
