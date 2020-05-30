import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:ps4_collection/models/models.dart';
import 'package:meta/meta.dart';


class GameApi {
  final String _baseUrl = "https://api-v3.igdb.com/games";
  final String apiKey;

  Client client = Client();

  GameApi({
    @required this.apiKey
  });

  Future<List<Game>> fetchGames() async {
    var response = await client.post(
      this._baseUrl,
      headers: {
        "user-key": this.apiKey,
        "Content-Type": "application/json"
      },
      body: "fields name;",
    );

    if (response.statusCode != 200) {
      throw new Exception();
    }

    final json = jsonDecode(response.body);

    return (json as List).map((x) => Game.fromJson(x)).toList();
  }
}