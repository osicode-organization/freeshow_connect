import '../../../domain/entity/show_entity/show_layouts_entity.dart';

class ShowLayoutsModel extends ShowLayoutsEntity {
  const ShowLayoutsModel({
    required super.name,
    required super.notes,
    required super.slides,
  });

  factory ShowLayoutsModel.fromJson(Map<String, dynamic> json) {
    return ShowLayoutsModel(
      name: json['name'],
      notes: json['notes'],
      slides: List<Map<String, String>>.from(json['slides']),
    );
  }
}
