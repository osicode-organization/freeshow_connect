import 'package:freeshow_connect/src/data/models/projects_models/project_entry_model.dart';

import '../../../domain/entity/projects_entity/project_data_entity.dart';

class ProjectDataModel extends ProjectDataEntity {
  const ProjectDataModel({required super.action, required super.data});

  factory ProjectDataModel.fromJson(Map<String, dynamic> json) {
    var dataMap = (json['data'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(key, ProjectEntryModel.fromJson(value)),
    );
    return ProjectDataModel(action: json['action'], data: dataMap);
  }
}
