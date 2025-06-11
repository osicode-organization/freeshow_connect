import 'package:freeshow_connect/src/data/models/show_models/show_details_model.dart';

import '../../../domain/entity/show_entity/show_data_entity.dart';

class ShowDataModel extends ShowDataEntity {
  ShowDataModel({
    required super.action,
    required super.id,
    required super.data,
  });

  factory ShowDataModel.fromJson(Map<String, dynamic> json) {
    return ShowDataModel(
      action: json['action'],
      id: json['id'],
      data: ShowDetailsModel.fromJson(json['data']),
    );
  }
}
