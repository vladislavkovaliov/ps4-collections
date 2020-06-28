import 'package:equatable/equatable.dart';
import 'package:ps4_collection/models/cover.dart';

class Game extends Equatable {
  final int id;
  final String name;
  final List<dynamic> genres;
  final String summary;
  final Cover cover;
  final List<String> screenshots;

  Game({
      this.id,
      this.name,
      this.genres,
      this.cover,
      this.summary,
      this.screenshots});

  @override
  List<Object> get props => [id, name, genres, cover, summary];

  static map(dynamic array) {
    if (array == null) return [];

    return array.map((x) => x as int).toList();
  }

  static Game fromJson(dynamic json) {
    return Game(
        id: json["id"],
        name: json["name"],
        genres: Game.map(json["genres"]),
        summary: json["summary"],
        cover: json["cover"] != null ? Cover.fromJson(json["cover"]) : null,
        screenshots: (json["screenshots"] as List)
            .map((e) =>
                "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/${e["image_id"]}.jpg")
            .toList());
  }

  @override
  String toString() =>
      'Game { id: $id, name: $name, genres: $genres, cover: $cover, summary: $summary, screenshots: $screenshots }';
}
