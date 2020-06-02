import 'package:meta/meta.dart';
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/api.dart';

class GameRepository {
  final GameApi gameApi;

  GameRepository({
    @required this.gameApi
  });

  Future<List<Game>> fetchGames() async {
    return this.gameApi.fetchGames();
  }

  Future<List<Game>> searchGameByName(String name) async {
    return this.gameApi.searchGameByName(name);
  }
}