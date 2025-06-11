import 'package:freeshow_connect/src/data/models/shows_models/show_item_model.dart';

import '../../../domain/entity/shows_entity/show_data_entity.dart';

class ShowDataModel extends ShowDataEntity {
  const ShowDataModel({required super.action, required super.data});

  factory ShowDataModel.fromJson(Map<String, dynamic> json) {
    var dataMap = (json['data'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(key, ShowItemModel.fromJson(value)),
    );

    return ShowDataModel(action: json['action'], data: dataMap);
  }
}
