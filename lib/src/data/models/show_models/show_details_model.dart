import 'package:freeshow_connect/src/data/models/show_models/show_layouts_model.dart';
import 'package:freeshow_connect/src/data/models/show_models/show_settings_model.dart';
import 'package:freeshow_connect/src/data/models/show_models/show_slides_group_model.dart';
import 'package:freeshow_connect/src/data/models/show_models/show_timestamps_model.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_details_entity.dart';

class ShowDetailsModel extends ShowDetailsEntity {
  const ShowDetailsModel({
    required super.name,
    required super.origin,
    required super.private,
    required super.category,
    required super.settings,
    required super.timestamps,
    required super.quickAccess,
    required super.meta,
    required super.slides,
    required super.layouts,
    required super.media,
    required super.showId,
  });

  factory ShowDetailsModel.fromJson(Map<String, dynamic> json) {
    return ShowDetailsModel(
      name: json['name'],
      origin: json['origin'] ?? "",
      private: json['private'],
      category: json['category'],
      settings: ShowSettingsModel.fromJson(json['settings']),
      timestamps: ShowTimestampsModel.fromJson(json['timestamps']),
      quickAccess: json['quickAccess'] ?? {},
      meta: json['meta'] ?? {},
      slides: (json['slides'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, ShowSlidesGroupModel.fromJson(value)),
      ),
      layouts: (json['layouts'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, ShowLayoutsModel.fromJson(value)),
      ),
      media: json['media'] ?? {},
      showId: json['id'],
    );
  }
}
