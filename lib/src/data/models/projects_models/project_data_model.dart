import '../../../domain/entity/projects_entity/project_data_entity.dart';

class ProjectDataModel extends ProjectDataEntity {
  const ProjectDataModel({required super.action, required super.data});

  factory ProjectDataModel.fromJson(Map<dynamic, dynamic> map) {
    return ProjectDataModel(
      action: map['action'],
      data: map['data'],
      // .map((key, value) => MapEntry(key, ProjectEntryModel.fromJson(value)),),
    );
  }
}
