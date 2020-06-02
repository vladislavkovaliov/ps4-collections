import 'package:equatable/equatable.dart';

class Cover extends Equatable {
  final String url;

  Cover({
    this.url
  });

  @override
  List<Object> get props => [url];

  static Cover fromJson(dynamic json) {
    return Cover(url: json["url"]);
  }

  @override
  String toString() => 'Cover { url: $url }';
}