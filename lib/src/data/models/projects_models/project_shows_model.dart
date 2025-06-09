import '../../../domain/entity/projects_entity/project_shows_entity.dart';

class ProjectShowsModel extends ProjectShowsEntity {
  const ProjectShowsModel({required super.id});

  factory ProjectShowsModel.fromJson(Map<dynamic, dynamic> map) {
    return ProjectShowsModel(id: map['id']);
  }
}
