import '../../../domain/entity/projects_entity/projects_entity.dart';

class ProjectsModel extends ProjectsEntity {
  const ProjectsModel({
    required super.name,
    required super.created,
    required super.parent,
    required super.shows,
    required DateTime modified,
    required DateTime used,
  });
}
