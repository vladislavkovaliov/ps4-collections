import 'package:equatable/equatable.dart';

class Game extends Equatable {
  final int id;
  final String name;
  final List<dynamic> genres;
  final int cover;

  Game({this.id, this.name, this.genres, this.cover});

  @override
  List<Object> get props => [id, name, genres, cover];

  static mapGenres(dynamic genres) {
    if (genres == null) return [];

    return genres.map((x) => x as int).toList();
  }

  static Game fromJson(dynamic json) {
    return Game(
        id: json["id"],
        name: json["name"],
        genres: Game.mapGenres(json["genres"]),
        cover: json["cover"],
    );
  }

  @override
  String toString() => 'Game { id: $id, name: $name, genres: $genres, cover: $cover }';
}
