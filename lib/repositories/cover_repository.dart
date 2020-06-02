import 'package:meta/meta.dart';
import 'package:ps4_collection/models/models.dart';
import 'package:ps4_collection/services/api/api.dart';

class CoverRepository {
  final CoverApi coverApi;

  CoverRepository({
    @required this.coverApi
  });

  Future<List<Cover>> fetchCovers() {
    return this.coverApi.fetchCovers();
  }
}