import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/api.dart';

class GameRepository {
  final GameApi _gameApi;

  GameRepository({
    GameApi gameApi,
  }) : _gameApi = gameApi ?? GameApi();

  Future<List<Game>> fetchGames() async {
    return this._gameApi.fetchGames();
  }

  Future<List<Game>> searchGameByName(String name) async {
    return this._gameApi.searchGameByName(name);
  }

  Future<List<Game>> searchGameById(int id) async {
    return this._gameApi.searchGameById(id);
  }
}