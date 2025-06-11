import '../../../domain/entity/show_entity/show_timestamps_entity.dart';

class ShowTimestampsModel extends ShowTimestampsEntity {
  const ShowTimestampsModel({
    required super.created,
    required super.modified,
    required super.used,
  });

  factory ShowTimestampsModel.fromJson(Map<String, dynamic> json) {
    return ShowTimestampsModel(
      created: json['created'],
      modified: json['modified'] ?? 0,
      used: json['used'] ?? 0,
    );
  }
}
