import 'package:freeshow_connect/src/data/models/shows_models/timestamps_model.dart';

import '../../../domain/entity/shows_entity/show_item_entity.dart';

class ShowItemModel extends ShowItemEntity {
  const ShowItemModel({
    required super.name,
    required super.category,
    required super.timestamps,
    required super.quickAccess,
    required super.origin,
  });

  factory ShowItemModel.fromJson(Map<String, dynamic> json) {
    return ShowItemModel(
      name: json['name'],
      category: json['category'],
      timestamps: TimestampsModel.fromJson(json['timestamps']),
      quickAccess: json['quickAccess'] ?? {},
      origin: json['origin'] ?? '',
    );
  }
}
