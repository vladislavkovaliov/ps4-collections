import 'package:meta/meta.dart';
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/game_api.dart';

class GameRepository {
  final GameApi gameApi;

  GameRepository({
    @required this.gameApi
  });

  Future<List<Game>> fetchGames() async {
    return this.gameApi.fetchGames();
  }
}