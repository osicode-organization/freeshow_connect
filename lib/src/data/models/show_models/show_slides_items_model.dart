import 'package:freeshow_connect/src/data/models/show_models/show_items_lines_model.dart';
import 'package:freeshow_connect/src/domain/entity/show_entity/show_slides_items_entity.dart';

class ShowSlidesItemsModel extends ShowSlidesItemsEntity {
  const ShowSlidesItemsModel({
    required super.type,
    required super.lines,
    required super.style,
    required super.align,
    required super.auto,
  });

  factory ShowSlidesItemsModel.fromJson(Map<String, dynamic> json) {
    return ShowSlidesItemsModel(
      type: json['type'],
      lines:
          (json['lines'] as List<dynamic>)
              .map((line) => ShowItemsLinesModel.fromJson(line))
              .toList(),
      style: json['style'],
      align: json['align'],
      auto: json['auto'],
    );
  }
}
