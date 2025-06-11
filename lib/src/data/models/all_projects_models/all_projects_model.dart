import '../../../domain/entity/all_projects_entity/all_projects_entity.dart';

class AllProjectsModel extends AllProjectsEntity {
  const AllProjectsModel({
    required super.projectId,
    required super.projectName,
    required super.projectCreated,
    required super.projectParent,
    required super.projectShows,
    required DateTime projectModified,
    required DateTime projectUsed,
  });
}
