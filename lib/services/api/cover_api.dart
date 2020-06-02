import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ps4_collection/models/models.dart';
import 'package:meta/meta.dart';

class CoverApi {
  final String _baseUrl = "https://api-v3.igdb.com/covers";
  final String apiKey;
  final http.Client httpClient;

  CoverApi({
    @required this.apiKey,
    @required this.httpClient,
  });

  Future<List<Cover>> fetchCovers() async {
    var response = await httpClient.post(
      this._baseUrl,
      headers: {
        "user-key": this.apiKey,
      },
      body: "fields url;",
    );

    if (response.statusCode != 200) {
      throw new Exception();
    }

    final json = jsonDecode(response.body);

    return (json as List).map((x) => Cover.fromJson(x)).toList();
  }
}