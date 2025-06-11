import '../../../domain/entity/all_shows_entity/all_shows_item_entity.dart';
import 'all_shows_timestamps_model.dart';

class AllShowsItemModel extends AllShowsItemEntity {
  const AllShowsItemModel({
    required super.name,
    required super.category,
    required super.timestamps,
    required super.quickAccess,
    required super.origin,
  });

  factory AllShowsItemModel.fromJson(Map<String, dynamic> json) {
    return AllShowsItemModel(
      name: json['name'],
      category: json['category'],
      timestamps: AllShowsTimestampsModel.fromJson(json['timestamps']),
      quickAccess: json['quickAccess'] ?? {},
      origin: json['origin'] ?? '',
    );
  }
}
