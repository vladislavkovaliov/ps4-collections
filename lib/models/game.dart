import 'package:equatable/equatable.dart';

class Game implements Equatable {
  final int id;
  final String name;

  Game({
    this.id,
    this.name
  });

  @override
  List<Object> get props => [id, name];

  @override
  // TODO: implement stringify
  bool get stringify => throw UnimplementedError();

  static Game fromJson(dynamic json) {
    return Game(
        id: json["id"],
        name: json["name"]
    );
  }

  @override
  String toString() => 'Game { id: $id, name: $name }';
}