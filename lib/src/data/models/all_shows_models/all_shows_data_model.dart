import 'package:freeshow_connect/src/data/models/all_shows_models/all_shows_item_model.dart';

import '../../../domain/entity/all_shows_entity/all_shows_data_entity.dart';

class AllShowsDataModel extends AllShowsDataEntity {
  const AllShowsDataModel({required super.action, required super.data});

  factory AllShowsDataModel.fromJson(Map<String, dynamic> json) {
    var dataMap = (json['data'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(key, AllShowsItemModel.fromJson(value)),
    );

    return AllShowsDataModel(action: json['action'], data: dataMap);
  }
}
