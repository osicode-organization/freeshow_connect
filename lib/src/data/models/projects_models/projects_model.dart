import '../../../domain/entity/projects_entity/projects_entity.dart';

class ProjectsModel extends ProjectsEntity {
  const ProjectsModel({
    required super.projectId,
    required super.projectName,
    required super.projectCreated,
    required super.projectParent,
    required super.projectShows,
    required DateTime projectModified,
    required DateTime projectUsed,
  });
}
