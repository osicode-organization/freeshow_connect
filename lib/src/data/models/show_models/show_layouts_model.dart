import '../../../domain/entity/show_entity/show_layouts_entity.dart';

class ShowLayoutsModel extends ShowLayoutsEntity {
  const ShowLayoutsModel({
    required super.name,
    required super.notes,
    required super.slides,
  });

  factory ShowLayoutsModel.fromJson(Map<String, dynamic> json) {
    /*final dataList =
        (json['slides'] as List<Map<String, dynamic>>)
            .map((item) => {item.keys.toString(): item.values.toString()})
            .toList();*/
    final List<Map<String, dynamic>> slidesData =
        (json['slides'] is List)
            ? List<Map<String, dynamic>>.from(json['slides'] ?? [])
            : [];

    final dataList =
        slidesData.isNotEmpty
            ? slidesData
                .map((item) => {item.keys.toString(): item.values.toString()})
                .toList()
            : <Map<String, String>>[];
    return ShowLayoutsModel(
      name: json['name'],
      notes: json['notes'],
      slides: dataList,
    );
  }
}
