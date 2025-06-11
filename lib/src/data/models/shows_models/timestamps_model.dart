import '../../../domain/entity/shows_entity/timestamps_entity.dart';

class TimestampsModel extends TimestampsEntity {
  const TimestampsModel({
    required super.created,
    required super.modified,
    required super.used,
  });

  factory TimestampsModel.fromJson(Map<String, dynamic> json) {
    return TimestampsModel(
      created: json['created'],
      modified: json['modified'] ?? 0,
      used: json['used'] ?? 0,
    );
  }
}
