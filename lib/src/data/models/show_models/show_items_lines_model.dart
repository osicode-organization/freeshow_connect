import 'package:freeshow_connect/src/data/models/show_models/show_lines_text_model.dart';

import '../../../domain/entity/show_entity/show_items_lines_entity.dart';

class ShowItemsLinesModel extends ShowItemsLinesEntity {
  const ShowItemsLinesModel({required super.align, required super.text});

  factory ShowItemsLinesModel.fromJson(Map<String, dynamic> json) {
    return ShowItemsLinesModel(
      align: json['align'] ?? "",
      text:
          (json['text'] as List<dynamic>)
              .map((txt) => ShowLinesTextModel.fromJson(txt))
              .toList(),
    );
  }
}
