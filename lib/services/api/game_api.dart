import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ps4_collection/models/models.dart';
import 'package:meta/meta.dart';


class GameApi {
  final String _baseUrl = "https://api-v3.igdb.com/games";
  final String apiKey;
  final http.Client httpClient;

  GameApi({
    @required this.apiKey,
    @required this.httpClient,
  });

  Future<List<Game>> fetchGames() async {
    var response = await httpClient.post(
      this._baseUrl,
      headers: {
        "user-key": this.apiKey,
      },
      body: "fields name,genres,cover;",
    );
    
    if (response.statusCode != 200) {
      throw new Exception();
    }

    final json = jsonDecode(response.body);

    return (json as List).map((x) => Game.fromJson(x)).toList();
  }


  Future<List<Game>> searchGameByName(String name) async {
    var response = await httpClient.post(
      this._baseUrl,
      headers: {
        "user-key": this.apiKey,
      },
      body: "fields name,genres,cover;\n" +
            'search "$name";',
    );

    if (response.statusCode != 200) {
      throw new Exception();
    }

    final json = jsonDecode(response.body);

    return (json as List).map((x) => Game.fromJson(x)).toList();
  }
}