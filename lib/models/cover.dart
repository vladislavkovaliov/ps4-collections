import 'package:equatable/equatable.dart';

class Cover extends Equatable {
  final int id;
  final String url;
  final int game;
  final String imageId;

  Cover({
    this.id,
    this.url,
    this.game,
    this.imageId,
  });

  @override
  List<Object> get props => [id, url, game];

  static Cover fromJson(dynamic json) {
    return Cover(
        id: json["id"],
        url: "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/${json["image_id"]}.jpg",
        game: json["game"],
        imageId: json["image_id"]);
  }

  @override
  String toString() => 'Cover { id: $id, url: $url, game: $game, imageId: $imageId }';
}
