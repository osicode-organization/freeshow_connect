import '../../../domain/entity/show_entity/show_lines_text_entity.dart';

class ShowLinesTextModel extends ShowLinesTextEntity {
  const ShowLinesTextModel({required super.value, required super.style});

  factory ShowLinesTextModel.fromJson(Map<String, dynamic> json) {
    return ShowLinesTextModel(value: json['value'], style: json['style']);
  }
}
