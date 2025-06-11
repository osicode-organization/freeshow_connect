import '../../../domain/entity/all_shows_entity/all_shows_timestamps_entity.dart';

class AllShowsTimestampsModel extends AllShowsTimestampsEntity {
  const AllShowsTimestampsModel({
    required super.created,
    required super.modified,
    required super.used,
  });

  factory AllShowsTimestampsModel.fromJson(Map<String, dynamic> json) {
    return AllShowsTimestampsModel(
      created: json['created'],
      modified: json['modified'] ?? 0,
      used: json['used'] ?? 0,
    );
  }
}
