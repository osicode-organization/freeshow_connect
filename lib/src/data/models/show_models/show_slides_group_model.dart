import 'package:freeshow_connect/src/data/models/show_models/show_slides_items_model.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_slides_group_entity.dart';

class ShowSlidesGroupModel extends ShowSlidesGroupEntity {
  ShowSlidesGroupModel({
    required super.group,
    required super.color,
    required super.settings,
    required super.notes,
    required super.items,
    required super.globalGroup,
  });
  factory ShowSlidesGroupModel.fromJson(Map<String, dynamic> json) {
    return ShowSlidesGroupModel(
      group: json['group'] ?? "",
      color: json['color'] ?? "",
      settings: json['settings'] ?? {},
      notes: json['notes'],
      items:
          (json['items'] as List<dynamic>)
              .map((item) => ShowSlidesItemsModel.fromJson(item))
              .toList(),
      globalGroup: json['globalGroup'] ?? "",
    );
  }
}
