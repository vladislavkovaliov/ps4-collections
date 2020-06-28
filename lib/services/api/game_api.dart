import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/keys/api_keys.dart';

class GameApi {
  final String _baseUrl = "https://api-v3.igdb.com/games";
  final String _apiKey;
  final http.Client _httpClient;

  GameApi({
    String apiKey,
    http.Client httpClient,
  })  : _httpClient = httpClient ?? http.Client(),
        _apiKey = apiKey ?? APIKeys.igdbKey;

  Future<List<Game>> fetchGames() async {
    var response = await _httpClient.post(
      this._baseUrl,
      headers: {
        "user-key": this._apiKey,
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
    var response = await _httpClient.post(
      this._baseUrl,
      headers: {
        "user-key": this._apiKey,
      },
      body: "fields name,genres,cover;\n" + 'search "$name";',
    );

    if (response.statusCode != 200) {
      throw new Exception();
    }

    final json = jsonDecode(response.body);

    return (json as List).map((x) => Game.fromJson(x)).toList();
  }

  Future<List<Game>> searchGameById(int id) async {
    var response = await _httpClient.post(
      this._baseUrl,
      headers: {
        "user-key": this._apiKey,
      },
      body: "fields name,genres,cover.*,summary,screenshots.*;\n" +
          'where id = $id;',
    );

    if (response.statusCode != 200) {
      throw new Exception();
    }

    final json = jsonDecode(response.body);

    return (json as List).map((x) => Game.fromJson(x)).toList();
  }
}
