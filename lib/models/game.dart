import 'package:equatable/equatable.dart';

class Game extends Equatable {
  final id;
  final String name;
  final List<dynamic> genres;

  Game({this.id, this.name, this.genres});

  @override
  List<Object> get props => [id, name, genres];

  static mapGenres(dynamic genres) {
    if (genres == null) return [];

    return genres.map((x) => x as int).toList();
  }

  static Game fromJson(dynamic json) {
    return Game(
        id: json["id"],
        name: json["name"],
        genres: Game.mapGenres(json["genres"]));
  }

  @override
  String toString() => 'Game { id: $id, name: $name, genres: $genres }';
}
