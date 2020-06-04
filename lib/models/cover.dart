import 'package:equatable/equatable.dart';

class Cover extends Equatable {
  final int id;
  final String url;
  final int game;

  Cover({
    this.id,
    this.url,
    this.game,
  });

  @override
  List<Object> get props => [id, url, game];

  static Cover fromJson(dynamic json) {
    return Cover(id: json["id"], url: json["url"], game: json["game"]);
  }

  @override
  String toString() => 'Cover { id: $id, url: $url, game: $game }';
}