import 'package:equatable/equatable.dart';

class Game extends Equatable {
  final int id;
  final String name;

  Game({
    this.id,
    this.name
  });

  @override
  List<Object> get props => [id, name];

  static Game fromJson(dynamic json) {
    return Game(
        id: json["id"],
        name: json["name"]
    );
  }

  @override
  String toString() => 'Game { id: $id, name: $name }';
}