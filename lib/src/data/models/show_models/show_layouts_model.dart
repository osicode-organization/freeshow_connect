import '../../../domain/entity/show_entity/show_layouts_entity.dart';

class ShowLayoutsModel extends ShowLayoutsEntity {
  const ShowLayoutsModel({
    required super.name,
    required super.notes,
    required super.slides,
  });

  factory ShowLayoutsModel.fromJson(Map<String, dynamic> json) {
    final dataList =
        (json['slides'] as List<Map<String, dynamic>>)
            .map((item) => {item.keys.toString(): item.values.toString()})
            .toList();
    return ShowLayoutsModel(
      name: json['name'],
      notes: json['notes'],
      slides: dataList,
    );
  }
}
